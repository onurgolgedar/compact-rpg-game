var mouseOnBody = is_mouse_on()

draw_set_color(c_white) draw_set_alpha(0.9*image_alpha)
	draw_set_color(c_windowback)
		draw_roundrect_ext(x-offset, y-offset, x+width+offset, y+height+offset, 17, 17, 0)
	draw_set_color(onFront ? c_window : c_dkgray) draw_set_alpha(0.38*image_alpha)
		draw_roundrect_ext(x, y+height_ext_top+offset, x+width, y+height, 17, 17, 0)
		draw_roundrect_ext(x+offset, y+height_ext_top+offset+offset, x+width-offset, y+height-offset, 17, 17, 0)

		draw_roundrect_ext(x, y, x+width, y+height_ext_top/2-offset/2, 17, 17, 0)
draw_set_default() draw_set_alpha(1*image_alpha)

draw_set_color(c_white) draw_set_alpha(1*image_alpha) draw_set_font(fontWindowTitle) draw_set_center()
	draw_text_outlined(x+width/2, y+(height_ext_top/2-offset/2)/2+2, title, 2, c_black, 10, 1, 1, 0)
draw_set_default()

mouseOnButton = undefined

// Page Buttons
var pageButtonEdge = 20
var pageButtonWidthFactor = 3.15
var pageButton_x, pageButton_y
for (var i = 0; i < pageCount; i++) {
	draw_set_alpha(1*image_alpha)
	pageButton_x[i] = x+offset+i*(offset*2+pageButtonEdge*pageButtonWidthFactor)
	pageButton_y[i] = y+(height_ext_top/2-offset/2)/2+pageButtonEdge/2+offset*2
    
	if (mouseOnBody and global.dmx > pageButton_x[i] and global.dmx < pageButton_x[i]+pageButtonEdge*pageButtonWidthFactor and
		global.dmy > pageButton_y[i] and global.dmy < pageButton_y[i]+pageButtonEdge and !is_click_blocked()) {
		draw_set_color(c_ltlime)
		mouseOnButton = i
	}
	else
		draw_set_color(page-1 == i ? c_ltgray : c_dkgray)
     
	var beforeColor = draw_get_color()
	draw_set_color(c_black)
		draw_roundrect(pageButton_x[i]-2, pageButton_y[i]-2,
		pageButton_x[i]+pageButtonEdge*pageButtonWidthFactor+2, pageButton_y[i]+pageButtonEdge+2, 0)
	draw_set_color(beforeColor)	
		draw_roundrect(pageButton_x[i], pageButton_y[i],
		pageButton_x[i]+pageButtonEdge*pageButtonWidthFactor, pageButton_y[i]+pageButtonEdge, 0)
	draw_set_color(c_black)
	draw_set_alpha(1*image_alpha)
    
	draw_set_center() draw_set_font(fontMain)
		var txt = ""
		if (i == 0)
			txt = "Info"
		/*else if (i == 1)
			txt = "Stats"
		else if (i == 2)
			txt = "Titles"*/
		draw_text_transformed(pageButton_x[i]+pageButtonEdge*pageButtonWidthFactor/2, pageButton_y[i]+pageButtonEdge/2+2, txt, 0.7, 0.7, 0)
	draw_set_default()
}
	
if (page == 1) {
	var between = 30
	draw_set_valign(fa_center)
	draw_set_color(c_white)
		draw_text_outlined(x+offset+5, y+height_ext_top+offset+offset+18, "CO-OP ID", 1, c_black, 10, 1, 1, 0)
	draw_set_color(c_ltgray) draw_set_halign(fa_right)
		draw_text_outlined(x+width-offset-10, y+height_ext_top+offset+offset+18, global.coopID, 1, c_black, 10, 0.8, 0.8, 0)
	draw_set_default()
}

draw_set_alpha(1)

event_inherited()