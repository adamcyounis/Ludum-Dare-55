/// @description Insert description here
// You can write your code in this editor
if(current_time - _timeAtLastSpawn > _spawnFrequency){
	spawnMonster();
}

if(_spawnFrequency> 3000){
	_spawnFrequency--;
}