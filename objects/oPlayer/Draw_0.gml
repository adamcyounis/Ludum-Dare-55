/// @description Insert description here
// You can write your code in this editor

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
draw_sprite(Hand, 0, _handPos.x, _handPos.y);


drawSpriteGhosting();
