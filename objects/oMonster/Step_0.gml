/// @description Insert description here
// You can write your code in this editor
var _prevLoyal = _loyal;
scale();
if(global._souls > 0){
	pickDirection();
}
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

if(!_prevLoyal && _loyal){
	audio_play_sound(Thanks, 0, false);
}