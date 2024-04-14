global._score = 0;
global._souls =50;
global._player = 0;
window_set_cursor(cr_cross);

global._soulScale = 0.06;

function gameRestart(){

	game_restart();
	global._souls = 50;
	global._score = 0;

}

function getPlayerPos(){
	return vec(global._player.x, global._player.y);
}