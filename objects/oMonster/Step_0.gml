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
//flip skull sprite if monster is facing left
_skull.image_xscale = _e._vel.x >=0 ? -1 : 1;

updateParticles();