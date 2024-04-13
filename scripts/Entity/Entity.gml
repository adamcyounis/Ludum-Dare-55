// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Entity(body, decay) constructor{
    _vel = {x:0,y:0};
	_body = body;
	_decay = decay;
	moveAndCollide = function(){
		var _v = _vel;
		with(_body){			
			
			var _collisions = move_and_collide(_v.x *delta_time/global._dtm, _v.y*delta_time/global._dtm, oSolid);
			for(var i = 0; i < array_length(_collisions); i++){
				var _collision = _collisions[i];

				if( _collision.object_index == oWall){
					_v.x = 0;
				}
	
				if( _collision.object_index == oFloor){
					_v.y = 0;
				}
			}
		}
	}
	
	
	decel = function (){
		_vel = mult(_vel, _decay);
	}
	
}