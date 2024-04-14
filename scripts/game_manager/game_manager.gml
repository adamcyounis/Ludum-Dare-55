global._score = 0;
global._souls =100;
global._player = 0;
global._hearts = 3;

global._messages = ds_list_create();
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

function notifyBonus(_message, _souls){
	//throw text up on the screen of the message
	ds_list_add( global._messages, {m:_message, t:current_time});
	//and add the souls to the global
	global._souls += _souls;
}

function log(v){
	show_debug_message(v);
}