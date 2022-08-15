if (keyboard_check(vk_control) and global.selectedPlayer_SERVER != undefined) {
	with (global.selectedPlayer_SERVER) {
		x = mouse_x
		y = mouse_y
	}
}