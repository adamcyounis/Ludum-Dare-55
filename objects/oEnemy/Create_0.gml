/// @description Insert description here
// You can write your code in this editor
_souls = random_range(10,30);
_baseMoveSpeed = 30;
_me = self;

_e = new Entity(self, 0.9);

enum target{
	PREY,
	SOUL,
	PLAYER,
	PREDATOR
}

_myTarget = target.PLAYER;

function grow(amount){
	_souls++;	
}

function getSoul(_vision){

	var _result = {_found: false, _pos: vec(0,0)};
	var _soul = instance_nearest(x, y, oSoul);
	var _soulPos;
	if(_soul != noone){	

		_soulPos = vec(_soul.x, _soul.y);
		
		_result = {_found: true, _pos: _soulPos};
	}
	
	return _result;	
}

function getPrey(_vision){
	
	var _result = {_found: false, _pos: vec(0,0)};
	//get the nearest prey
	var _biggestPrey = noone;
	var found = false
	var _me = self;
	with (oEnemy){
	
		var notMe = id != other.id;
		if(notMe){		
			if(point_distance(self.x, self.y, other.x, other.y) < _vision){
				if(_souls < _me._souls){
					if(!found){
						_biggestPrey = self;
						found = true;
					}else{
						var biggerPrey = _souls > _biggestPrey._souls;

						if(biggerPrey){
							_biggestPrey = self;
						}
					}
				}
			}
		}
	}
	
	if(_biggestPrey != noone){
		_result = {_found: true, _pos: vec(_biggestPrey.x, _biggestPrey.y)};
	}
	return _result;	
}

function getPredator(_vision){	
	

	var _result = {_found: false, _pos: vec(0,0)};
	var found = false;
	//get the nearest predator
	var _biggest = _me;
	with (oEnemy){
		
		if(point_distance(self.x, self.y, other.x, other.y) < _vision){
		
			var notMe = id != other.id;
			if(notMe){
				if(_souls > _biggest._souls ){
					_biggest = self;
				}
			}
		}
	}

	if(_biggest != noone && _biggest.id != _me.id){
		_result = {_found: true, _pos: vec(_biggest.x, _biggest.y)};
	}
	return _result;	
}

function getPlayer(_vision){
	var _result = {_found: false, _pos: vec(0,0)};
	var _playerPos = vec(global._player.x, global._player.y);
	
	if(distance(vec(x,y), _playerPos)< _vision){
		_result = {_found: true, _pos: _playerPos};
	}
	
	return _result;
}


function pickDirection(){
	var _moveSpeed = _baseMoveSpeed  - (_souls*0.2);
	_moveSpeed = clamp(_moveSpeed,1,20);
	
	var _predatorResult = getPredator(150);
	var _preyResult = getPrey(200);
	var _playerResult = getPlayer(300);
	var _soulResult = getSoul(600);
	
	var _dir = vec(0,0);

	if(_predatorResult._found){
	//move away from predator
		_dir = get_direction(_predatorResult._pos, vec(x,y));
		_myTarget = target.PREDATOR;
		
	}else if(_preyResult._found){
		_dir = get_direction(vec(x,y), _preyResult._pos);	
		_myTarget = target.PREY;
		
	}else if(_playerResult._found){
		_dir = get_direction(vec(x,y), _playerResult._pos);
		_myTarget = target.PLAYER;
		
	}else if(_soulResult._found){
		_dir = get_direction(vec(x,y), _soulResult._pos);
		_myTarget = target.SOUL;
	}

	if(_dir != vec(0,0)){
		_e._vel = mult(_dir, _moveSpeed);
	}
}


function pickColour(){
	switch(_myTarget){
		
		case target.PLAYER:
			image_blend = c_red;
		break;
	
		case target.PREY:
			image_blend = c_blue;
		break;
	
		case target.PREDATOR:
			image_blend = c_white;
		break;
		
		case target.SOUL:
			image_blend = c_green;
		break;
	
	}
}




