if (owner != undefined) {
	if (instance_exists(owner)) {
		if (owner_isOnGUI) {
			x = owner.x+offset_x
			y = owner.y+offset_y
			depth = owner.depth-1
		}
		else {
			x = screen_point(owner.x, 0)+offset_x
			y = screen_point(owner.y, 1)+offset_y
		}
	}
}
else {
	x = device_mouse_x_to_gui(0)+offset_x
	y = device_mouse_y_to_gui(0)+offset_y
}

if (!owner_isOnGUI) {
	if (x+text_width+padding_x*2+10 > display_get_gui_width())
		x -= text_width+padding_x*2+spacing
	if ( y-padding_y*2-text_height-10 < 0)
		y += padding_y*2+text_height+(spacing+25)*!owner_isOnGUI
}
else
	y -= height