with (contGameController) {
	if (!is_mouse_on_any_window()) {
		if (other.mouseOnBLogo)
			event_perform(ev_keypress, ord("I"))
		else if (other.mouseOnCLogo)
			event_perform(ev_keypress, ord("C"))
		else if (other.mouseOnQLogo)
			event_perform(ev_keypress, ord("J"))
		else if (other.mouseOnSLogo)
			event_perform(ev_keypress, ord("Y"))
	}
}