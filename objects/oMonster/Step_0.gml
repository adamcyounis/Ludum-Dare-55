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