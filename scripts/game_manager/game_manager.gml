global._score = 0;
global._souls =100;
global._player = 0;
window_set_cursor(cr_cross);

global._soulScale = 0.06;

function gameRestart(){
	game_restart();
	_souls = 100;
	_score = 0;
	
}