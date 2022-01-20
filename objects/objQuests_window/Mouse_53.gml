if (is_mouse_on() and !is_click_blocked()) {	
	if (mouseOnButton < pageCount) {
		page = mouseOnButton+1
		prepDone = false
	}
	else if (mouseOnButton >= 100) {
	}
}
	
event_inherited()