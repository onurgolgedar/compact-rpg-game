if (surface != undefined) {
	if (hasBackground) {
		draw_set_alpha(0.9) draw_set_color(make_color_rgb(15, 15, 15))
			draw_roundrect_ext(x, y+2, x+width, y+height, 18, 18, false)
		draw_set_color(c_black) draw_set_alpha(1)
	}
	
	if (surface_exists(surface)) {
		draw_surface(surface, x+padding_x, y-padding_y-text_height)
		
		// ?
		draw_surface(surface, x+padding_x, y-padding_y-text_height)
		draw_surface(surface, x+padding_x, y-padding_y-text_height)
	}
	else
		event_user(0)
}