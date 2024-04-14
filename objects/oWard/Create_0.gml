//creates an edge chain of points set by the player with setPoint
// when the player finishes the ward, the ward is created and the points are deleted
// any monsters within the ward will die
_endRange = 32;
_wardPoints = ds_list_create();
_lineWidth = 2;
_finished = false;
_finishTime = 0;
_costPerPixel = 0.1;
function startWard(){
    _finished = false;
    _wardPoints = ds_list_create();
}

function setPoint(_point){
	var _candle = instance_create_depth(_point.x, _point.y, 1, oCandle);
    ds_list_add(_wardPoints, _candle);
}

function finishWard(){
	//delete all monsters inside the ward
    for(var i = 0; i < instance_number(oMonster); i++){
        with (oMonster){
            if(other.point_in_ward(vec(x,y))){
                 die();
            }
        }
    }
    _finished = true;
    _finishTime = current_time;
   // clearWard();
}

function point_in_ward(_point){
    show_debug_message("checking point in ward");
    //check if the point is inside the shape made by the points
    var _inside = false;
    
    //consider a segment made between the point and another point one room_height above it
    var _p1 = _point;
    var _p2 = vec(_point.x, _point.y - room_height);

    //check how many times the segment intersects with any of the segments made by the points
    var _intersections = 0;
    for(var i = 0; i < ds_list_size(_wardPoints); i++){
        var _p3 = _wardPoints[| i];
        var _p4 = _wardPoints[| (i + 1) mod ds_list_size(_wardPoints)];
        if(segment_intersect(_p1, _p2, _p3, _p4)){
            _intersections++;
        }
    }

    show_debug_message("{0} intersections", _intersections);


    //if the number is odd, we are inside the shape
    if(_intersections mod 2 == 1){
        _inside = true;
    }
    return _inside;
}


function clearWard(){
    for(var i = 0; i < ds_list_size(_wardPoints); i++){
        instance_destroy(_wardPoints[| i]);
    }
    ds_list_destroy(_wardPoints);
    _wardPoints = ds_list_create();

    _finished = false;
    _finishTime = 0;
   
}

function checkFinishWard(){
    if(ds_list_size(_wardPoints) < 3){
        return;
    }

    var _pPos = getPlayerPos();
    var _distanceToPlayer = point_distance(_pPos.x, _pPos.y, _wardPoints[|0].x, _wardPoints[|0].y);
    if(_distanceToPlayer < _endRange){
        finishWard();
        return true;
    }
    return false;
}

function setupDebugWard(){
	setPoint(vec(10,10));
	setPoint(vec(100,10));
	setPoint(vec(100,100));
	setPoint(vec(10,100));
    show_debug_message(ds_list_size(_wardPoints));
}

function calculateCost(_pos){

    if(ds_list_size(_wardPoints) == 0){
        return 0;
    }
    //cost is equal to the distance from the player to the last point
    var _lastPoint = _wardPoints[| ds_list_size(_wardPoints) - 1];
    show_debug_message(_lastPoint.y);
    var _dist = point_distance(_pos.x, _pos.y, _lastPoint.x, _lastPoint.y);
    return _dist * _costPerPixel;
}

//setupDebugWard();
