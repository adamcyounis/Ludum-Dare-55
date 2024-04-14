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
