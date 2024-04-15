/// @description Insert description here
// You can write your code in this editor

if(!audio_is_playing(Reaver_Music) && global._souls >=0){
	audio_play_sound(Reaver_Music,1, true);
}