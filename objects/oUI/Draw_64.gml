
//draw a rect from the top centre of the screen outward representing the number of souls in the global scope
draw_set_color(c_white);
//calculate the centre of the screen 
var _centre = vec(display_get_gui_width()/2, display_get_gui_height()/2);
var _barScale = 6;
var _barWidth = global._souls * _barScale;
var _hb = _barWidth / 2;
draw_rectangle(_centre.x - _hb,10, _centre.x + _hb ,20, false);

//centre align text
draw_set_halign(fa_center);

draw_text(_centre.x,30, "souls");

//scale up the text
draw_text(_centre.x,60,string( "score: {0}", global._score));
/*
//draw the player's health as heart sprites at 2x scale in the top middle centre;
var _heartScale = 2;
var _heartWidth = sprite_get_width(sHeart) * _heartScale;
var _hw = _heartWidth / 2;

for(var i = 0; i < global._hearts; i++){
    draw_sprite_ext(sHeart, 0, _centre.x - _hw + i * _heartWidth, 80, _heartScale, _heartScale, 0, c_white, 1);
}
*/