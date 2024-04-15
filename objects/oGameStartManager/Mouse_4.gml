/// @description Insert description here
// You can write your code in this editor

if(_slideIndex < ds_list_size(_slides)){

	
	//image is next slide
	sprite_index = _slides[| _slideIndex];
	//stretch sprite to fill
	image_xscale = room_width / sprite_get_width(sprite_index);
	image_yscale = room_height / sprite_get_height(sprite_index);
	_slideIndex ++;
	gpu_set_tex_filter(false);
}else{
	
	audio_play_sound(TitleTheme, 0, true);
	room_goto(LevelScreen);
}
