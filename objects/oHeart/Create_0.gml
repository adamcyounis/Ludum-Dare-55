/// @description Insert description here
// You can write your code in this editor
_magnetism = 48;

_spawnTime = current_time;
_collectInvuln = 300;

_v = vec(0,0);
_e = new Entity(self, 0.93);

function canCollect(){
	return lifeTime() > _collectInvuln;
}

function lifeTime(){
	return current_time - _spawnTime;
}