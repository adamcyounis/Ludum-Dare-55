/// @description Insert description here
// You can write your code in this editor

 _s = 0.04;
 _halfW = 320;
_halfH = 240;
function follow(_t){
	x += (_t.x - x) * _s;
	y += (_t.y -y) * _s;

	clampPosition();	
	camera_set_view_pos(view_camera[0],x - _halfW, y-_halfH);

}




function clampPosition(){
	var _xboundary = _halfW;
	var _yboundary = _halfH;

	var _minx =_xboundary +sprite_width/2;
	var _maxx = room_width- sprite_width/2 - _xboundary;
	var _miny = _yboundary + sprite_height/2;
	var _maxy =  room_height- sprite_height/2 - _yboundary;
	x = clamp(x, _minx , _maxx);
	y = clamp(y, _miny, _maxy);
}