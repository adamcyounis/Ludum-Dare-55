global._score = 0;
global._souls =100;
global._player = 0;
global._hearts = 3;
window_set_cursor(cr_cross);

global._soulScale = 0.06;

function gameRestart(){

	with (oMonster){
	    part_system_destroy(_ps);
	}
	
	game_restart();
	global._souls = 100;
	global._score = 0;
	global._hearts = 3;
}

function getPlayerPos(){
	return vec(global._player.x, global._player.y);
}

global._red = #c43a79;
global._green = #4be89a;