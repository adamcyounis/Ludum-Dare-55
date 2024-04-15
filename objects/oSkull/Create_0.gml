/// @description Insert description here
// You can write your code in this editor
_monster = noone;
_souls = 0;

_timeAtDead =0;
function drop(){
	
	if(_monster != noone){
		_souls = _monster._souls;
		_monster = noone;
	}
	sprite_index = sDeadSkull;
	_timeAtDead = current_time;

}