/// @description Insert description here
// You can write your code in this editor
/// @description Insert description here
// You can write your code in this editor
_timeAtLastSpawn = 0;
_spawnFrequency = 10000 - (current_time/20000);
_threshold = 64;


function spawnMonster(){
	
	_timeAtLastSpawn = current_time;
	//pos is random position inside room bounds;
	
	var valid = false;
	var _spawnVec = vec(0,0);

	while(!valid){
		_spawnVec.x = random_range(_threshold, room_width - _threshold);
		_spawnVec.y = random_range(_threshold , room_height - _threshold);
		if(distance(_spawnVec, vec(global._player.x, global._player.y)) > 300){
			valid = true;
		}
	}
	
	instance_create_layer(_spawnVec.x, _spawnVec.y, "Instances", oMonster);
}
	
for(var i = 0; i < random_range(3,6); i++){
	spawnMonster();
}