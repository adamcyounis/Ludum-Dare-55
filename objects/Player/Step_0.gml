/// @description Insert description here
// You can write your code in this editor

var _left = keyboard_check(vk_left);
var _right = keyboard_check(vk_right);
var _up = keyboard_check(vk_up);
var _down = keyboard_check(vk_down);

_move = {x:0, y:0};

if (_left || _right) {
    _move.x = (_right - _left)* _speed;
}

if (_up || _down) {
    _move.y = (_down - _up)* _speed;
}

_move = normalize(_move);

if(_move.x != 0 ){  
    _vel.x += _move.x *_speed;
}

if(_move.y != 0){
	_vel.y += _move.y *_speed; 
}


if(keyboard_check_pressed(vk_space)){
	//_dash_time = current_time;
	_vel.y = -20;
}
	
if(_dash_time > 0){
	var _ac_struct = animcurve_get_channel(_my_curve,"_dk");
	var _t = current_time-_dash_time;
	_vel.x += animcurve_channel_evaluate( _ac_struct,_t)*_speed*10;
}
/*
if(get_length({x:hspeed, y:vspeed}) > _max_speed){
    var _normalized = normalize({x:hspeed, y:vspeed});
    _vel.x = _normalized.x * _max_speed;
    _vel.y = _normalized.y * _max_speed;
}

*/
//_vel = mult(_vel, _decay);

_vel.x *= _decay;
_vel = add(_vel, _grav);

show_debug_message(_vel);

var _collisions= move_and_collide(_vel.x *delta_time/global._dtm, _vel.y*delta_time/global._dtm, oSolid);

for(var i = 0; i < array_length(_collisions); i++){
	var _collision = _collisions[i];
	if( _collision.object_index == oWall){
		_vel.x = 0;
	}
	if( _collision.object_index == oFloor){
		if(_vel.y <= 0){	
			_vel.y = 0;
		}
	}
}
