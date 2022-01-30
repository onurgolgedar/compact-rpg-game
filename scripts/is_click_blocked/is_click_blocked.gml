/// @param id*
function is_click_blocked(_id) {	
	var _window = _id == undefined ? id : _id
		
	with (parWindow) {
		if (is_mouse_on() and depth < _window.depth)
		    return true
	}

	return false
}