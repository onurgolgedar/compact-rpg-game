if (global.drawServer and global.selectedPlayer != undefined) {
	with (global.selectedPlayer) {
		draw_set_alpha(0.5) draw_set_color(c_aqua)
			draw_circle(x, y, 10, false)
		draw_set_alpha(1) draw_set_color(c_black)
	}
	
	with (parTarget_SERVER) {
		var x2 = x+lengthdir_x(35, image_angle+50)
		var y2 = y+lengthdir_y(35, image_angle+50)
			
		var x3 = x+lengthdir_x(35, image_angle-50)
		var y3 = y+lengthdir_y(35, image_angle-50)

		var attack_x = lengthdir_x(115, image_angle)
		var attack_y = lengthdir_y(115, image_angle)

		draw_set_alpha(0.3) draw_set_color(c_red)
			draw_circle(x, y, 2, 0)
			draw_circle(x2, y2, 2, 0)
			draw_circle(x3, y3, 2, 0)
		draw_set_alpha(1) draw_set_default()

		draw_set_alpha(0.15)
		draw_circle(x+attack_x, y+attack_y, 35, 0)
		draw_circle(x+attack_x*3/5, y+attack_y*3/5, 25, 0)
		draw_circle(x+attack_x*1/4, y+attack_y*1/4, 25, 0)
		draw_set_alpha(1)
	}
}

