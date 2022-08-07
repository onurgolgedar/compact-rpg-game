if (is_mouse_on() and !is_click_blocked()) {	
	if (mouseOnButton < pageCount) {
		page = mouseOnButton+1
		audio_play_sound(sndMenuTick, 1, 0)
	}
}
	
event_inherited()