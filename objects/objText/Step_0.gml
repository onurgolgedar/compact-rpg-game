if (owner != undefined) {
	if (instance_exists(owner)) {
		x = screen_point(owner.x, 0)+offset_x
		y = screen_point(owner.y, 1)+offset_y
	}
}
else {
	x = device_mouse_x_to_gui(0)+offset_x
	y = device_mouse_y_to_gui(0)+offset_y
}

if (x+text_width+padding_x*2+10 > display_get_gui_width())
	x -= text_width+padding_x*2+spacing
if (y-padding_y*2-text_height-10 < 0)
	y += padding_y*2+text_height+spacing+25