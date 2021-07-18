if (global.drawServer and global.selectedPlayer != undefined) {
	with (global.selectedPlayer) {
		draw_set_alpha(0.5) draw_set_color(c_aqua)
			draw_circle(x, y, 10, false)
		draw_set_alpha(1) draw_set_color(c_black)
	}
}