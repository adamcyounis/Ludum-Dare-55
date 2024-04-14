/// @description Insert description here
// You can write your code in this editor


//if the time since dead is greater than 10 seconds, start flashing faster and faster.
//on the 15th second, destroy the skull


var _timeSinceDead = current_time - _timeAtDead;
if(_monster == noone){
    if(_timeSinceDead > 10000){
        instance_destroy();
    } else if(_timeSinceDead > 8000){
        //flash the alpha of the skull
        image_alpha = _timeSinceDead mod 20 > 10? 0:1;
    }
}else{
	draw_text(x, y+40, string(round(_monster._souls)));
}

//draw text above head showing time since dead
 draw_self();   
draw_set_color(c_white);

