var mouseOnBody = is_mouse_on()

draw_set_color(c_white) draw_set_alpha(0.9*image_alpha)
	draw_set_color(COLOR_WINDOW_BACK)
		draw_roundrect_ext(x-offset, y-offset, x+width+offset, y+height+offset, 15, 15, 0)
	draw_set_color(onFront ? c_gray : c_dkgray) draw_set_alpha(0.1*image_alpha)
		draw_roundrect_ext(x, y, x+width, y+height, 15, 15, 0)
draw_set_default() draw_set_alpha(1*image_alpha)

draw_set_color(c_dkgray) draw_set_alpha(1*image_alpha) draw_set_font(fontWindowTitle)
	draw_text_outlined(x+offset, y+offset, title, 1, c_black, 15, 1, 1, 0)
draw_set_default()

/**/

draw_set_alpha(1)

event_inherited()