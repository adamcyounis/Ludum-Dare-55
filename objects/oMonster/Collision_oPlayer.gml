/// @description Insert description here
// You can write your code in this editor

if(_loyal || global._souls <= 0){
	return
}
if(other._invulnDuration == 0 || current_time - other._lastHurtTime > other._invulnDuration){
    if(global._souls > 200){
        global._souls /=3;

    }else {
		global._souls -= 30;
	}
	
	if(global._souls<=0){
        gameEnd();
    }
    other.bump(vec(x, y));	
    other._lastHurtTime = current_time;
    //play player hurt sounds
    audio_play_sound(choose(Hurt_1, Hurt_2, Hurt_3), 10, false);

}
