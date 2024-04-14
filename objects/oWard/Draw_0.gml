/// @description Insert description here
// You can write your code in this editor

//set line colour to white
draw_set_colour(c_white);
//change the line weight 
var _w = _finished? 6: 2;
//draw lines between the points
for(var i = 0; i < ds_list_size(_wardPoints)-1; i++){
    var _p1 = _wardPoints[| i];
    var _p2 = _wardPoints[| (i + 1)];
    draw_line_width(_p1.x, _p1.y, _p2.x, _p2.y,_w);
}

if(_finished){
    //draw a line between the last point and the first point
    var _p1 = _wardPoints[| 0];
    var _p2 = _wardPoints[| ds_list_size(_wardPoints) - 1];
    draw_line_width(_p1.x, _p1.y, _p2.x, _p2.y,_w);
}

//if unfinished but the player is holding shift, close the loop and make the last line flashing
if(!_finished && ds_list_size(_wardPoints) > 0){
    var _p1 = _wardPoints[| ds_list_size(_wardPoints) - 1];
    var _px = _wardPoints[| 0];
    if(_shiftHeld && ds_list_size(_wardPoints) >= 3){
 
        //make the fill alpha flash
        var _alpha = 0.5 + 0.5 * sin(current_time * 0.01);
        draw_set_alpha(_alpha);
        //if the player has enough souls, make it green, otherwise make it red
        draw_set_colour(global._souls >= calculateCost(_px)? global._green: global._red);

        //draw a line between the last and first points
        draw_line_width(_p1.x, _p1.y, _px.x, _px.y, 6);
    }
}

draw_set_alpha(1);
