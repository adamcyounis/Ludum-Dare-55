if(other.canCollect()){
	instance_destroy(other);
	global._score ++;
	global._souls ++;
	audio_play_sound(Soul_Get, 0, false);
}