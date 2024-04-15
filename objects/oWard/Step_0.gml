

if(keyboard_check_direct(vk_shift)){
    if(!_shiftHeld){
       _shiftHeld = true;
    }

    if(mouse_check_button_pressed(mb_right)){

        if(_finished){
           clearWard();
        }    
         tryFinishWard();

    }else if(mouse_check_button_pressed(mb_left)){
        if(_finished){
            clearWard();
        }
        var _cost = calculateCost(getPlayerPos());
        //if the global souls count is greater than the calculateCost();
        if(global._souls >= _cost){
            //if the ward is not finished, add a point to the ward
            setPoint(getPlayerPos());
            global._souls -=  _cost;
        
        }
   
    }
}

if(keyboard_check_released(vk_shift)){
     //_confirmed = true;
     _shiftHeld = false;

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