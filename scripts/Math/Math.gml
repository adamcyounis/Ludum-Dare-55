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

function distance(_to, _from){
	var _absx = abs(_from.x - _to.x);
	var _absy = abs(_from.y - _to.y);
	var _vec = vec(_absx,_absy );
	return get_length(_vec);
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
function mult(_v, _f){
    return {x: _v.x * _f, y: _v.y * _f};
}

function divide(_v, _f){

	if(_f == 0)	return 0;	
	
    return {x: _v.x / _f, y: _v.y / _f};

}

function add(_v, _v2){
    return {x: _v.x + _v2.x, y: _v.y + _v2.y};
}

function magnitude(_v){
	return sqrt(_v.x * _v.x + _v.y * _v.y);
}

function get_direction(_from, _to){
	var v = {x: _to.x - _from.x, y: _to.y - _from.y}
	v = normalize(v);
	 return v;
}



function vec(_x, _y){
	return { x: _x, y:_y};
}

function segment_intersect(_p1, _p2, _p3, _p4){
	
	var _denom = (_p4.y - _p3.y) * (_p2.x - _p1.x) - (_p4.x - _p3.x) * (_p2.y - _p1.y);
	var _num_a = (_p4.x - _p3.x) * (_p1.y - _p3.y) - (_p4.y - _p3.y) * (_p1.x - _p3.x);
	var _num_b = (_p2.x - _p1.x) * (_p1.y - _p3.y) - (_p2.y - _p1.y) * (_p1.x - _p3.x);
	var _ua = _num_a / _denom;
	var _ub = _num_b / _denom;
	if(_ua >= 0 && _ua <= 1 && _ub >= 0 && _ub <= 1){
		return true;
	}
	return false;
}