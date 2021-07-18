function is_mouse_on_any_window() {
	with (parWindow)
		if (is_mouse_on() or isHeld or isBoxHeld)
			return true

	return false
}