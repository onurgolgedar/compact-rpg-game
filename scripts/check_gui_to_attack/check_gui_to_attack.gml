function check_gui_to_attack() {
	return !is_mouse_on_any_window() and !is_mouse_on_any_clickable_npc() and !is_mouse_on_gui_buttons() and !is_mouse_on_skill_boxes()
}