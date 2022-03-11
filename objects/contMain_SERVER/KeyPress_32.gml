if (keyboard_check(vk_control) and keyboard_check(vk_shift)) {
	if (global.drawEventEnabled) {
		draw_enable_drawevent(0)
		global.drawEventEnabled = false
		if (global.socketID_player != undefined) {
			kick(global.socketID_player)
			global.socketID_player = undefined
		}
	}
	else {
		draw_enable_drawevent(1)
		global.drawEventEnabled = true
	}
}