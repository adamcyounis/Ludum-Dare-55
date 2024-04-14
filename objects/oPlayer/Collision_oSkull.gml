/// @description Insert description here
// You can write your code in this editor
if(other._monster == noone){
	instance_destroy(other);
	global._score += other._souls;
	global._souls += other._souls;
	audio_play_sound(Skull_get, 0, false);
}