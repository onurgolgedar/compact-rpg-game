function is_mouse_on_gui_buttons() {
	with (contDrawGUI)
		if (mouseOnBLogo or mouseOnCLogo or mouseOnMLogo or mouseOnQLogo or mouseOnSLogo)
			return true

	return false
}