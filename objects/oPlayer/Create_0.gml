/// @description Insert description here
// You can write your code in this editor
_speed = 15;
_base_speed = 15;
_max_speed = 14;
_dash_time = 0;
_dash_direction = vec(0,0);
_dash_speed = 120;
_dash_duration = 0.11;
_move = vec(0,0);

_time_at_fire = 0;
_soulSpeed = 60;
_rof = 100;

global._player = self;

_e = new Entity(self, 0.6);


//summoning variable
_summoning = noone;
_releasedSummon = true;
_timeAtSummonStart = 0;
_soulsPerMilli = 0.01;

//invulnerability variables
_lastHurtTime = 0;
_invulnDuration = 3000;

function handleKeyInput(){
	
	_speed = (_summoning == noone)? _base_speed: _base_speed*0.5;
	var _left = keyboard_check(ord("A"));
	var _right =keyboard_check(ord("D"));
	var _up = keyboard_check(ord("W"));
	var _down = keyboard_check(ord("S"));
	_move = {x:0, y:0};

	if (_left || _right) {
	    _move.x = (_right - _left)* _speed;
	}

	if (_up || _down) {
	    _move.y = (_down - _up)* _speed;
	}

	_move = normalize(_move);

	if(_move.x != 0 ){  
	    _e._vel.x += _move.x *_speed;
	}

	if(_move.y != 0){
		_e._vel.y += _move.y *_speed; 
	}
}

function tryDash(){
	if(_summoning == noone){
		if(keyboard_check_pressed(vk_space)){
			_dash_time = current_time;
			_dash_direction = normalize(_e._vel);
		}
		
		if(_dash_time > 0){
			var _ac_struct = animcurve_get_channel(_my_curve,"_dk");
			var _t =( current_time-_dash_time) / 1000;
			var _amount = animcurve_channel_evaluate( _ac_struct,_t/_dash_duration)*_dash_speed;
	
			_e._vel = add(_e._vel, mult(_dash_direction, _amount));
		}
	}
}


function clampSpeed(){	
	if(get_length({x:hspeed, y:vspeed}) > _max_speed){
	    var _normalized = normalize({x:hspeed, y:vspeed});
	    _e._vel.x = _normalized.x * _max_speed;
	    _e._vel.y = _normalized.y * _max_speed;
	}
}


function tryFire(){	
	var _pressingMouse = mouse_check_button(mb_left)
	var _hasSoul = global._souls > 1;
	var _onCooldown = current_time - _time_at_fire < _rof;
	
	if(_pressingMouse && _hasSoul && !_onCooldown){
		_time_at_fire = current_time;
		global._souls --;

		var _soul = instance_create_layer(x, y, "Instances", oSoul);
		var _dir = get_direction( vec(x,y),vec(mouse_x, mouse_y));
		_soul._e._vel = mult(_dir, _soulSpeed);
		_soul.sprite_index = sSoulPlayer;
	}
}

function trySummon(){
	var _cost = (current_time - _timeAtSummonStart) * _soulsPerMilli;
	var holding = mouse_check_button(mb_right);
	if(_releasedSummon == false && !holding){
		_releasedSummon = true;
	}
	
	if(_summoning == noone){

		if(holding && _releasedSummon){
			//start spawning new summoningSign
			var _spawnDistance = 64;
			var _dir = get_direction( vec(x,y),vec(mouse_x, mouse_y));
			var _spawnPos = vec(x + _dir.x * _spawnDistance,y + _dir.y * _spawnDistance); 
			_summoning = instance_create_layer(_spawnPos.x, _spawnPos.y, "Instances", oSummonSign);
			_releasedSummon = false;
			_timeAtSummonStart = current_time;
			
		}
	} else {
		if(holding && global._souls >_cost + 1){
			_summoning._souls = _cost;
		}else{
			//release summoning sign
			global._souls -= _summoning._souls;
			_summoning.release();	
			_summoning = noone;
	
		}
	}
	
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

function bump(_bumperPos){
	var _dir = get_direction(_bumperPos, vec(x,y));
	var _bumpSpeed = 300;
	_e._vel = add(_e._vel, mult(_dir, _bumpSpeed));	
}