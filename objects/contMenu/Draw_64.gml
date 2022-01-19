var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

var xx = 125
var yy = 517
var width = 110
var height = 45

draw_set_color(c_dkgray)
	draw_roundrect(xx-width/2, yy-height/2, xx+width/2, yy+height/2, false)
draw_set_color(c_black)

var mouseHover = mx > xx-width/2 and mx < xx+width/2 and my > yy-height/2 and my < yy+height/2
if (mouseHover) {
	draw_set_alpha(0.3) draw_set_color(c_gray)
		draw_roundrect(xx-width/2, yy-height/2, xx+width/2, yy+height/2, false)
	draw_set_alpha(1) draw_set_color(c_black)
	
	if (device_mouse_check_button(0, mb_left))
		event_user(0)
}

draw_set_halign(fa_center) draw_set_valign(fa_center) draw_set_color(c_black)
	draw_text(xx, yy, "START")
draw_set_halign(fa_left) draw_set_valign(fa_top) draw_set_color(c_black)

var xx = 581
var yy = 607
var width = 120
var height = 45

draw_set_color(c_dkgray)
	draw_roundrect(xx-width/2, yy-height/2, xx+width/2, yy+height/2, false)
draw_set_color(c_black)

var mouseHover = mx > xx-width/2 and mx < xx+width/2 and my > yy-height/2 and my < yy+height/2
if (mouseHover) {
	draw_set_alpha(0.3) draw_set_color(c_gray)
		draw_roundrect(xx-width/2, yy-height/2, xx+width/2, yy+height/2, false)
	draw_set_alpha(1) draw_set_color(c_black)
	
	if (device_mouse_check_button(0, mb_left))
		event_user(1)
}

draw_set_halign(fa_center) draw_set_valign(fa_center) draw_set_color(c_black)
	draw_text(xx, yy, "SIGN UP")
draw_set_halign(fa_left) draw_set_valign(fa_top) draw_set_color(c_black)