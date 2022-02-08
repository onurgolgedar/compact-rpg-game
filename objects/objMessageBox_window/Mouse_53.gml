if (is_mouse_on() and !is_click_blocked()) {	

}
	
	
var isHeld_before = isHeld

event_inherited()

if (!isHeld_before && isHeld) {
	alarm[1] = SEC*1.5
	
	//duration = maxDuration
}