/// @description Insert description here
// You can write your code in this editor
_souls = random_range(10,30);
_baseMoveSpeed = 30;
_me = self;
_loyalty = 0;
_loyal = false;
_e = new Entity(self, 0.9);


enum target{
	PREY,
	SOUL,
	PLAYER,
	PREDATOR
}

_myTarget = target.PLAYER;



_skull = instance_create_depth(x, y, 2, oSkull);
_skull._monster = self;

function isLoyal(){
	return  _loyal;
}

function grow(amount){
	_souls++;	
}

function getSoul(_vision){

	var _result = {_found: false, _pos: vec(0,0)};
	var _soul = instance_nearest(x, y, oSoul);
	var _soulPos;
	if(_soul != noone){	

		_soulPos = vec(_soul.x, _soul.y);
		
		_result = {_found: true, _pos: _soulPos};
	}
	
	return _result;	
}

function getPrey(_vision){
	
	var _result = {_found: false, _pos: vec(0,0)};
	//get the nearest prey
	var _biggestPrey = noone;
	var found = false
	var _me = self;
	with (oMonster){
	
		var notMe = id != other.id;
		if(notMe){		
			if(point_distance(self.x, self.y, other.x, other.y) < _vision){
				if(_souls < _me._souls){
					if(!found){
						_biggestPrey = self;
						found = true;
					}else{
						var biggerPrey = _souls > _biggestPrey._souls;

						if(biggerPrey){
							_biggestPrey = self;
						}
					}
				}
			}
		}
	}
	
	if(_biggestPrey != noone){
		_result = {_found: true, _pos: vec(_biggestPrey.x, _biggestPrey.y)};
	}
	return _result;	
}

function getPredator(_vision){	
	
	var _result = {_found: false, _pos: vec(0,0)};
	var found = false;
	//get the nearest predator
	var _biggest = _me;
	with (oMonster){
		
		if(point_distance(self.x, self.y, other.x, other.y) < _vision){
		
			var notMe = id != other.id;
			if(notMe){
				if(_souls > _biggest._souls ){
					_biggest = self;
				}
			}
		}
	}

	if(_biggest != noone && _biggest.id != _me.id){
		_result = {_found: true, _pos: vec(_biggest.x, _biggest.y)};
	}
	return _result;	
}

function getPlayer(_vision){
	var _result = {_found: false, _pos: vec(0,0)};
	
	if(!isLoyal()){
		var _playerPos = vec(global._player.x, global._player.y);	
		if(distance(vec(x,y), _playerPos)< _vision){
			_result = {_found: true, _pos: _playerPos};
		}
	}
	return _result;
}


function pickDirection(){
	var _moveSpeed = _baseMoveSpeed  - (_souls*0.3);
	_moveSpeed = clamp(_moveSpeed,1,20);
	
	var hw = sprite_width/2;	
	var _predatorResult = getPredator(150 + hw);
	var _preyResult = getPrey(200 + hw);
	
	if(isLoyal()){
		_predatorResult = getPredator(50 + hw);
		_preyResult = getPrey(1000 + hw);
	}
	

	var _playerResult = getPlayer(300 + hw);
	var _soulResult = getSoul(600 + hw);
	
	var _dir = vec(0,0);
	var _prevTarget = _myTarget;
	if(_predatorResult._found){
	//move away from predator
		_dir = get_direction(_predatorResult._pos, vec(x,y));
		_myTarget = target.PREDATOR;
		
	}else if(_preyResult._found){
		_dir = get_direction(vec(x,y), _preyResult._pos);	
		_myTarget = target.PREY;
		
	}else if(_playerResult._found){
		_dir = get_direction(vec(x,y), _playerResult._pos);
		_myTarget = target.PLAYER;
		if(_prevTarget != _myTarget){
			audio_play_sound(choose(Monster_1, Monster_2, Monster_3, Monster_4, Monster_5), 0, false);
		}
		
	}else if(_soulResult._found){
		_dir = get_direction(vec(x,y), _soulResult._pos);
		_myTarget = target.SOUL;
	}

	if(_dir != vec(0,0)){
		_e._vel = add(_e._vel, mult(_dir, _moveSpeed/10));
	}
	
	
}


function pickColour(){
	switch(_myTarget){
		
		case target.PLAYER:
			image_blend = global._red;//c_red;
		break;
	
		case target.PREY:
			image_blend = #4f62e4;//c_blue;
		break;
	
		case target.PREDATOR:
			image_blend = #ebb677;// c_white;
		break;
		
		case target.SOUL:
			image_blend = global._green;//c_green;
		break;
	
	}
	//set image alpha to 0
	image_alpha = 1;
}

function scale(){
	image_xscale = _souls *global._soulScale;
	image_yscale = _souls *global._soulScale;
}

scale();

function summon(_value, _toBeLoyal){
	_souls = _value;

	if(_toBeLoyal){
		_loyalty = _value * 10;
		_loyal = true;
	}
}

function die(){
	_skull.drop();
	instance_destroy();
	//destroy particle system
	
	part_emitter_destroy(_ps, _pemit1);
	part_system_destroy(_ps);
	
	//play any of the death sounds

	var _sound = choose(Monster_7, Monster_8, Monster_9);
	audio_play_sound(_sound, 1, false);

}


function clampPosition(){
	var _boundary = 32;
	var _minx = _boundary +sprite_width/2;
	var _maxx = room_width- sprite_width/2 - _boundary;
	var _miny = _boundary + sprite_height/2;
	var _maxy =  room_height- sprite_height/2 - _boundary;
	x = clamp(x, _minx , _maxx);
	y = clamp(y, _miny, _maxy);
}



//adds velocity away from the room edges
//move with more force the closer to the edge
function moveAwayFromWall(){

	var _boundary = 92;
	var _minx = _boundary + sprite_width/2;
	var _maxx = room_width - sprite_width/2 - _boundary;
	var _miny = _boundary + sprite_height/2;
	var _maxy =  room_height- sprite_height/2 - _boundary;

	var _dir = vec(0,0);
	var _factor = 10;
	if(x < _minx){
		var _dist = _minx - x;
		_e._vel = add(_e._vel, vec(_dist/_factor ,0));
	}
	
	if(x > _maxx){
		var _dist = x - _maxx;
		_e._vel = add(_e._vel, vec(-_dist/_factor ,0));
	}

	if(y < _miny){
		var _dist = _miny - y;
		_e._vel = add(_e._vel, vec(0, _dist/_factor));
	}

	if(y > _maxy){
		var _dist = y - _maxy;
		_e._vel = add(_e._vel, vec(0, -_dist/_factor));
	}

}

_ps = part_system_create();
_ptype1 = part_type_create();
_pemit1 = part_emitter_create(_ps);
function setupParticles(){
	
	part_system_layer(_ps, "Particles");
	//pMonsterBody
	part_system_draw_order(_ps, false);
	part_system_global_space(_ps, false);
	//Emitter

	part_type_shape(_ptype1, pt_shape_disk);
	part_type_size(_ptype1, 1, 1, -0.01, -0.01);
	part_type_scale(_ptype1, 0.5, 0.5);
	part_type_speed(_ptype1, 0.7, 1, -0.01, 0);
	part_type_direction(_ptype1, 0, 360, 0, 0);
	part_type_gravity(_ptype1, 0, 271);
	part_type_orientation(_ptype1, 0, 0, 0, 0, false);
	part_type_colour3(_ptype1, $FFFFFF, $FFFFFF, $FFFFFF);
	part_type_alpha3(_ptype1, 1, 1, 1);
	part_type_blend(_ptype1, false);
	part_type_life(_ptype1, 80, 80);

	part_emitter_region(_ps, _pemit1, -64, 64, -64, 64, ps_shape_ellipse, ps_distr_gaussian);
	part_emitter_stream(_ps, _pemit1, _ptype1, 2);
	part_system_position(_ps,x, y);
}

function updateParticles(){

	var _scaleFactor = (_souls/35);
	var _inset = 0.75;
	var _hsw = (sprite_width/2) *_inset;
	var _hsh = (sprite_height/2)*_inset;
	//set the particle colour to be the same as the monster
	part_type_colour1(_ptype1, image_blend);
	part_emitter_region(_ps, _pemit1,  -_hsw,_hsw, -_hsh, _hsh, ps_shape_ellipse, ps_distr_gaussian);
	part_emitter_stream(_ps, _pemit1, _ptype1, 2*(_souls/10));
	part_system_position(_ps,x, y);
	part_type_scale(_ptype1,  _scaleFactor,  _scaleFactor);

}

setupParticles();

