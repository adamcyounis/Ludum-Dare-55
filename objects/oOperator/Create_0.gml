/// @description Insert description here
// You can write your code in this editor

 _s = 0.04;
function follow(_t){
	x += (_t.x - x) * _s;
	y += (_t.y -y) * _s;
	
	camera_set_view_pos(view_camera[0],x - 320, y-240);
}