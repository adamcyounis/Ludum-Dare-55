/// @description Insert description here
// You can write your code in this edito

if(keyboard_check_direct(vk_shift)){
    if(!_shiftHeld){
        _dismissed = false;
        _timeAtShiftHeld = current_time;
       _shiftHeld = true;
    }

    //if the shift key is held for 0.5 seconds, try and finish the ward
    if(current_time - _timeAtShiftHeld > 800 ){
        if(!_dismissed){
            show_debug_message("held for 500");
            var completed = tryFinishWard();
            if(completed){
                clearWard();
                _dismissed = true;
            }
        }
    }
}

if(keyboard_check_released(vk_shift)){

    if(_finished){
        clearWard();
    }
    var _canTap = !(_shiftHeld && current_time - _timeAtShiftHeld > 200);
    if(_canTap){
        var _cost = calculateCost(getPlayerPos());
        //if the global souls count is greater than the calculateCost();
        if(global._souls >= _cost){
            //if the ward is not finished, add a point to the ward
            setPoint(getPlayerPos());
            global._souls -=  _cost;
        }
    }

	_shiftHeld = false;
    _dismissed = true;


}


if(_finished && current_time - _finishTime > 3000){
    clearWard();
}

//checkFinishWard();

//check to see if the left mouse button was pressed.
//if so, add a point to the ward

/*
if(mouse_check_button_pressed(mb_left)){
    var _point = vec(mouse_x, mouse_y);
    //if the size of the ward is < 3, add the point to the list
    if(ds_list_size(_wardPoints) < 3){
        ds_list_add(_wardPoints, _point);
    }
    else{
        //if the size of the ward is >= 3, check if the point is close to the first point
        var _firstPoint = _wardPoints[| 0];
        var _distance = distance(_point, _firstPoint);
        if(_distance < _endRange){
            //if the point is close to the first point, finish the ward
            finishWard();
        }
        else{
            //if the point is not close to the first point, add the point to the list
            ds_list_add(_wardPoints, _point);
        }
    }  
}

*/