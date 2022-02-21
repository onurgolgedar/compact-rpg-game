function is_mouse_on_any_clickable_npc() {
	with (parClickableNPC)
		if (is_mouse_on())
			return true

	return false
}