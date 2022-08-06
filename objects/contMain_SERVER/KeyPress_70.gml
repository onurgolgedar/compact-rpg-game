if (keyboard_check(vk_ralt) and global.selectedPlayer != undefined) {
	with (global.selectedPlayer) {
		x = mouse_x
		y = mouse_y
	}
}