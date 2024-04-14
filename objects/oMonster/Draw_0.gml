/// @description Insert description here
// You can write your code in this editor

//draw a hand sprite either side of the monster, moving up and down in a sin wave
var _t = current_time * 0.01;
if(_e._vel.x <= 0){
    draw_sprite(rightHand, 0, x - 40, y + 10 + sin(_t) * 2);
    draw_sprite(leftHand, 0, x + 20, y + 20 + sin(_t) * 2);
}else{
//mirror everything if facing left
    draw_sprite_ext(leftHand, 0, x - 20, y + 20 + sin(_t) * 2, -1, 1, 0, c_white, 1);
    draw_sprite_ext(rightHand, 0, x + 40, y + 10 + sin(_t) * 2, -1, 1, 0, c_white, 1);
}
