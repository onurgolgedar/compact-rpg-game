if (keyboard_check(vk_control) and global.selectedPlayer != undefined) {
	with (global.selectedPlayer) {
		x = mouse_x
		y = mouse_y
	}
}