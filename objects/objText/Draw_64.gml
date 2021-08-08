if (surface != undefined) {
	draw_set_alpha(0.9) draw_set_color(make_color_rgb(15, 15, 15))
		draw_roundrect_ext(x, y+2, x+text_width+padding_x*2+2, y-padding_y*2-text_height, 18, 18, false)
	/*draw_set_color(c_dkgray)
		draw_roundrect_ext(x+spacing, y-spacing+2, x+text_width+padding_x*2-spacing+2, y-padding_y*2-text_height+spacing, 9, 9, false)*/
	draw_set_color(c_black) draw_set_alpha(1)
	
	if (surface_exists(surface)) {
		draw_surface(surface, x+padding_x, y-padding_y-text_height)
		
		// ?
		draw_surface(surface, x+padding_x, y-padding_y-text_height)
		draw_surface(surface, x+padding_x, y-padding_y-text_height)
	}
	else
		event_user(0)
}