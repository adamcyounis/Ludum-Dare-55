/// @description Insert description here
// You can write your code in this editor
_souls = 0;


function grow(_value){
	_souls += _value;
}

function release(){
	var _enemy = instance_create_layer(x, y, "Instances", oMonster);
	_enemy.summon(_souls);
	instance_destroy();
}
function scale(){
	image_xscale = _souls *global._soulScale;
	image_yscale = _souls *global._soulScale;
}
scale();