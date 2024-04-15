/// @description Insert description here
// You can write your code in this editor

//draw a black ellipse below the player
draw_set_color(#515277);


draw_ellipse(x-20, y+25, x+20, y+35, false);

var _rad = 30;
var _playerPos = vec(x, y);
var _staffAnchor = add(_playerPos, vec(_rad,10));
var _handAnchor = add(_playerPos, vec(-_rad*0.7,8));

var _mouseToPlayer = vec(mouse_x - x, mouse_y - y);
var _offset =  mult(_mouseToPlayer, 0.1);

var _staffPos = add(_staffAnchor, _offset);
var _handPos = add(_handAnchor, mult(_offset, -0.3));

draw_self();
draw_sprite(Staff, 0, _staffPos.x, _staffPos.y);

//holding shift and ward not confirmed?

log(!instance_find(oWard, 0)._confirmed);
var _warding = keyboard_check(vk_shift);
draw_sprite(_warding? sCandle: Hand, 0, _handPos.x, _handPos.y);

drawSpriteGhosting();
