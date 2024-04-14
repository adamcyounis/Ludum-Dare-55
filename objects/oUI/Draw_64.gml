
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
draw_set_font(MetalSmall);

draw_text(_centre.x,30, "souls");

draw_set_font(MetalLarge);

//scale up the text
draw_text(_centre.x,60,string( "score: {0}", round(global._score)));
/*
//draw the player's health as heart sprites at 2x scale in the top middle centre;
var _heartScale = 2;
var _heartWidth = sprite_get_width(sHeart) * _heartScale;
var _hw = _heartWidth / 2;

for(var i = 0; i < global._hearts; i++){
    draw_sprite_ext(sHeart, 0, _centre.x - _hw + i * _heartWidth, 80, _heartScale, _heartScale, 0, c_white, 1);
}
*/

//go through the global._messages list and draw the messages on the screen
var _numMessages = ds_list_size(global._messages);
var _messageY = 200;
for(var i = 0; i < _numMessages; i++){
    var _message = global._messages[| i];
    var _time = _message.t;
    var _messageText = _message.m;
    var _timeSince = current_time - _time;
    var _alpha = 1 - (_timeSince / 2000);

    if(_alpha < 0){
        ds_list_delete(global._messages, i);
        i--;
        _numMessages--;
        continue;
    }

    draw_set_alpha(_alpha);
    draw_text(_centre.x, _messageY, _messageText);
    _messageY += 40;
}