/// @description Insert description here
// You can write your code in this editor

if(other._invulnDuration == 0 || current_time - other._lastHurtTime > other._invulnDuration){
    if(global._souls > 200){
        global._souls /=2;

    }else if(global._souls > 50){
		global._souls -= 50;
	}else{		
        gameRestart();
    }
    other.bump(vec(x, y));	
    other._lastHurtTime = current_time;
    //play player hurt sounds
    audio_play_sound(choose(Hurt_1, Hurt_2, Hurt_3), 10, false);

}
