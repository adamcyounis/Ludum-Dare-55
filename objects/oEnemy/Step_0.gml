/// @description Insert description here
// You can write your code in this editor

image_xscale = _souls *0.04;
image_yscale = _souls *0.04;

pickDirection();

pickColour();

_e.decel();
_e.moveAndCollide();