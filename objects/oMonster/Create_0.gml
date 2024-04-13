/// @description Insert description here
// You can write your code in this editor
_souls = random_range(10,30);
_baseMoveSpeed = 30;
_me = self;

_e = new Entity(self, 0.9);

enum target{
	PREY,
	SOUL,
	PLAYER,
	PREDATOR
}

_myTarget = target.PLAYER;

_timeAtSummoned = 0;
_loyaltyPeriod = 5000;

_skull = instance_create_depth(x, y, 2, oSkull);
_skull._monster = self;

function isLoyal(){
	return _timeAtSummoned != 0 && (current_time - _timeAtSummoned) < _loyaltyPeriod;
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
	var _moveSpeed = _baseMoveSpeed  - (_souls*0.2);
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
		
	}else if(_soulResult._found){
		_dir = get_direction(vec(x,y), _soulResult._pos);
		_myTarget = target.SOUL;
	}

	if(_dir != vec(0,0)){
		_e._vel = mult(_dir, _moveSpeed);
	}
}


function pickColour(){
	switch(_myTarget){
		
		case target.PLAYER:
			image_blend = c_red;
		break;
	
		case target.PREY:
			image_blend = c_blue;
		break;
	
		case target.PREDATOR:
			image_blend = c_white;
		break;
		
		case target.SOUL:
			image_blend = c_green;
		break;
	
	}
}

function scale(){
	image_xscale = _souls *global._soulScale;
	image_yscale = _souls *global._soulScale;
}

scale();

function summon(_value){
	_souls = _value;
	_timeAtSummoned = current_time;
}

function die(){
	_skull.drop();
	instance_destroy();
}


function clampPosition(){
	var _boundary = 16;
	var _minx = _boundary +sprite_width/2;
	var _maxx = room_width- sprite_width/2 - _boundary;
	var _miny = _boundary + sprite_height/2;
	var _maxy =  room_height- sprite_height/2 - _boundary;
	x = clamp(x, _minx , _maxx);
	y = clamp(y, _miny, _maxy);
}