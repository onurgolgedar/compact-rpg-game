var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

draw_set_alpha(0.25)
	draw_rectangle(-1, -1, 390, room_height+1, 0)
	draw_rectangle(room_width+1, -1, room_width-420, room_height+1, 0)
draw_set_alpha(1)

draw_set_color(c_white) draw_set_font(fontMainBold_SERVER) draw_set_alpha(0.6)
	draw_text(1235, 120, "ACCOUNT CREATION")
	draw_text(55, 420-300, "ONLINE/COOP PLAY")
draw_set_color(c_ltlime)
	draw_text(55, 720, "HOST A GAME")

draw_set_alpha(0.35) draw_set_color(c_lime)
	draw_roundrect_ext(45, 760, 345, 840, 40, 40, false)
draw_set_color(c_white)
	draw_roundrect_ext(1225, 240-80, 1525, 650, 40, 40, false)
	draw_roundrect_ext(45, 160, 345, 490, 40, 40, false)
draw_set_color(c_black) draw_set_alpha(1) draw_set_font(fontMain)

var xx = 65
var yy = 800
var width = 260
var height = 45

draw_set_color(c_green)
	draw_roundrect_ext(xx, yy-height/2, xx+width, yy+height/2, 22, 22, false)
draw_set_color(c_black) draw_set_alpha(0.55)
	draw_roundrect_ext(xx, yy-height/2, xx+width, yy+height/2, 22, 22, false)
draw_set_alpha(1)

var mouseHover = mx > xx and mx < xx+width and my > yy-height/2 and my < yy+height/2
if (mouseHover) {
	draw_set_alpha(0.1) draw_set_color(c_lime)
		draw_roundrect_ext(xx, yy-height/2, xx+width, yy+height/2, 22, 22, false)
	draw_set_alpha(1) draw_set_color(c_black)
	
	if (device_mouse_check_button_pressed(0, mb_left)) {
		global.connectionGoal = 3
		event_user(0)
	}
}

draw_set_halign(fa_center) draw_set_valign(fa_center) draw_set_color(c_white)
	draw_text_transformed(xx+width/2, yy, "QUICK START", 1.3, 1.3, 0)
draw_set_halign(fa_left) draw_set_valign(fa_top) draw_set_color(c_black)

var xx = 65
var yy = 447
var width = 260
var height = 45

draw_set_color(c_green)
	draw_roundrect_ext(xx, yy-height/2, xx+width, yy+height/2, 22, 22, false)
draw_set_color(c_black) draw_set_alpha(0.55)
	draw_roundrect_ext(xx, yy-height/2, xx+width, yy+height/2, 22, 22, false)
draw_set_alpha(1)

var mouseHover = mx > xx and mx < xx+width and my > yy-height/2 and my < yy+height/2
if (mouseHover) {
	draw_set_alpha(0.1) draw_set_color(c_lime)
		draw_roundrect_ext(xx, yy-height/2, xx+width, yy+height/2, 22, 22, false)
	draw_set_alpha(1) draw_set_color(c_black)
	
	if (device_mouse_check_button_pressed(0, mb_left)) {
		global.connectionGoal = 1
		event_user(0)
	}
}

draw_set_halign(fa_center) draw_set_valign(fa_center) draw_set_color(c_white)
	draw_text_transformed(xx+width/2, yy, "LOGIN", 1.3, 1.3, 0)
draw_set_halign(fa_left) draw_set_valign(fa_top) draw_set_color(c_black)

var xx = 1306
var yy = 607
var width = 120
var height = 45

draw_set_color(c_dkgray)
	draw_roundrect_ext(xx-width/2, yy-height/2, xx+width/2, yy+height/2, 22, 22, false)
draw_set_color(c_black)

var mouseHover = mx > xx-width/2 and mx < xx+width/2 and my > yy-height/2 and my < yy+height/2
if (mouseHover) {
	draw_set_alpha(0.3) draw_set_color(c_gray)
		draw_roundrect_ext(xx-width/2, yy-height/2, xx+width/2, yy+height/2, 22, 22, false)
	draw_set_alpha(1) draw_set_color(c_black)
	
	if (device_mouse_check_button_pressed(0, mb_left)) {
		global.connectionGoal = -1
		event_user(1)
	}
}

draw_set_halign(fa_center) draw_set_valign(fa_center) draw_set_color(c_black)
	draw_text(xx, yy, "SIGN UP")
draw_set_halign(fa_left) draw_set_valign(fa_top) draw_set_color(c_black)