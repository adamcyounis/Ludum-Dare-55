/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_black);
draw_rectangle(0,0,200,100, false);
draw_set_color(c_white);

draw_text(10,10,string( "souls: {0}", global._souls));
draw_text(10,30,string( "score: {0}", global._score));
