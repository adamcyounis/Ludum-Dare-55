/// @description Insert description here
// You can write your code in this editor

//if the timer 
if(current_time - _timeAtLastSpawn > _spawnFrequency){
	var _pos = { x: 0, y: 0};
	_timeAtLastSpawn = current_time;
	//pos is random position inside room bounds;
	_pos.x = random_range(_threshold, room_width - _threshold);
	_pos.y = random_range(_threshold , room_height - _threshold); 
	instance_create_layer(_pos.x, _pos.y, "Instances", Soul);
}