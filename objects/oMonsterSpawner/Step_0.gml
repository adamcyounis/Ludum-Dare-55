/// @description Insert description here
// You can write your code in this editor
if(current_time - _timeAtLastSpawn > _spawnFrequency){

	_timeAtLastSpawn = current_time;
	//pos is random position inside room bounds;
	
	var valid = false;
	var _spawnVec = vec(0,0);
	while(!valid){
		_spawnVec.x = random_range(_threshold, room_width - _threshold);
		_spawnVec.y = random_range(_threshold , room_height - _threshold);
		if(distance(_spawnVec, vec(global._player.x, global._player.y) > 200)){
			valid = true;
		}
	}
	
	
	instance_create_layer(_spawnVec.x, _spawnVec.y, "Instances", oMonster);
}