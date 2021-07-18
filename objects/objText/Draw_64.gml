if (surface != undefined) {
	draw_set_color(c_black) draw_set_alpha(0.7)
		draw_roundrect_ext(x, y, x+text_width+padding_x*2, y-padding_y*2-text_height, 9, 9, false)
	draw_set_alpha(0.7) draw_set_color(c_maroon)
		draw_roundrect_ext(x+spacing, y-spacing, x+text_width+padding_x*2-spacing, y-padding_y*2-text_height+spacing, 9, 9, false)
	draw_set_color(c_white) draw_set_alpha(1)
	
	if (surface_exists(surface))
		draw_surface(surface, x+padding_x, y-padding_y-text_height)
	else
		event_user(0)
}