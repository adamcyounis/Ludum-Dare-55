/// @description Insert description here
// You can write your code in this editor

var _d = distance_to_object(global._player) ;
if(canCollect() && _d < _magnetism){
	var _pos = vec(x, y);
	var _pPos = vec(global._player.x,global._player.y);
	var _dir = get_direction(_pos,_pPos);

	x += _dir.x * (_magnetism-_d)*0.5;
	y += _dir.y* (_magnetism-_d)*0.5;

}

if(lifeTime() >200){
	_e.decel();
}
_e.moveAndCollide();