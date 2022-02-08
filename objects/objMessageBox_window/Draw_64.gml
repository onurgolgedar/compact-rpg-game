var mouseOnBody = is_mouse_on()
var mainAlpha = 0.9*image_alpha

draw_set_color(c_white) draw_set_alpha(mainAlpha)
	draw_set_color(c_windowback)
		draw_roundrect_ext(x-offset, y-offset, x+width+offset, y+height+offset, 15, 15, 0)
	draw_set_color(onFront ? c_gray : c_dkgray) draw_set_alpha(mainAlpha/9)
		draw_roundrect_ext(x, y, x+width, y+height, 15, 15, 0)
draw_set_default() draw_set_alpha(1)

draw_set_color(c_gray) draw_set_font(fontWindowTitle)
	draw_text_outlined(x+offset, y+offset, title, 1, c_black, 15, 1, 1, 0)
draw_set_default()

if (duration > 0) {
	var durationBarColor = (alarm[1] > 1 or isHeld) ? c_aqua : c_ltyellow
	draw_set_alpha(mainAlpha*(1-0.4*(duration > maxDuration)))
		draw_roundrect(x-offset, y-12, x+width+offset, y, 0)
    draw_set_color(durationBarColor) 
        draw_roundrect(x-offset+3, y-10, x+3+min(duration/maxDuration, 1)*(width+offset-6), y-2, 0)
	draw_set_color(c_black) draw_set_alpha(1)
}

/**/

event_inherited()