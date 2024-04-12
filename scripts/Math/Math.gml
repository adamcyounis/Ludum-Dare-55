// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global._dtm = 100000;

function normalize(_v){
	//do nan checks on each axis
	_v.x = is_nan(_v.x)? 0: _v.x;
    _v.y = is_nan(_v.y)? 0: _v.y;

	if(_v.x == 0 && _v.y == 0 ){
		return _v;
	}
	
	var _x = abs(_v.x);
	var _y = abs(_v.y);
    var _length = sqrt(_x * _x + _y * _y);
    var _normalized = {x:_v.x / _length, y: _v.y / _length};
    return _normalized;
}

function get_length(_v){
    
    //do nan checks on each axis
  	_v.x = is_nan(_v.x)? 0: _v.x;
    _v.y = is_nan(_v.y)? 0: _v.y;

    var _x = abs(_v.x);
	var _y = abs(_v.y);
    return sqrt(_x * _x + _y * _y);
}

//component based multiplication
function mult(_v, _x){
    return {x: _v.x * _x, y: _v.y * _x};
}

function add(_v, _v2){
    return {x: _v.x + _v2.x, y: _v.y + _v2.y};
}
