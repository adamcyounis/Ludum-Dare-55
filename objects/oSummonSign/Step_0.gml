/// @description Insert description here
// You can write your code in this editor
scale();

if(_releaseTimer  != -1){
	
	_releaseTimer --;	
		log(_releaseTimer);
	if(_releaseTimer > 0){
			grow(0.2);
	}
	
	if(_releaseTimer == 0){
	
		release(false);
	}
}