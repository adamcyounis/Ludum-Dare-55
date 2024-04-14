/// @description Insert description here
// You can write your code in this editor

scale();
pickDirection();
pickColour();

_e.decel();
_e.moveAndCollide();
moveAwayFromWall();
clampPosition();


_skull.x = x;
_skull.y = y;
_skull.image_xscale = _e._vel.x >=0 ? -1 : 1;

updateParticles();

if(_loyal){
    if(_loyalty == 0){
        _loyal = false;
    }
	_loyalty --;
}else{
    if(_loyalty > _souls*10){
        _loyal = true;
    }
}