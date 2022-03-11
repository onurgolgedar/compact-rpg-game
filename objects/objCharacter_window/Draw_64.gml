var mouseOnBody = is_mouse_on()

draw_set_color(c_white) draw_set_alpha(0.9*image_alpha)
	draw_set_color(c_windowback)
		draw_roundrect_ext(x-offset, y-offset, x+width+offset, y+height+offset, 15, 15, 0)
	draw_set_color(onFront ? c_window : c_dkgray) draw_set_alpha(0.38*image_alpha)
		draw_roundrect_ext(x, y+height_ext_top+offset, x+width, y+height, 15, 15, 0)
		draw_roundrect_ext(x+offset, y+height_ext_top+offset+offset, x+width-offset, y+height-offset, 15, 15, 0)

		draw_roundrect_ext(x, y, x+width, y+height_ext_top/2-offset/2, 15, 15, 0)
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
		draw_set_color(c_lime)
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
		else if (i == 1)
			txt = "Stats"
		else if (i == 2)
			txt = "Titles"
		draw_text_transformed(pageButton_x[i]+pageButtonEdge*pageButtonWidthFactor/2, pageButton_y[i]+pageButtonEdge/2+2, txt, 0.7, 0.7, 0)
	draw_set_default()
}
	
if (page == 1) {
	var between = 30
	draw_set_valign(fa_center)
	draw_set_color(c_white)
		draw_text_outlined(x+offset+5, y+height_ext_top+offset+offset+18, "Name", 1, c_black, 10, 1, 1, 0)
		draw_text_outlined(x+offset+5, y+height_ext_top+offset+offset+18+between, "Class", 1, c_black, 10, 1, 1, 0)
		draw_text_outlined(x+offset+5, y+height_ext_top+offset+offset+18+between*2, "Level", 1, c_black, 10, 1, 1, 0)
	
		with (objPlayer) {
			draw_text_outlined(other.x+other.offset+5, other.y+other.height-18-between*4, "Physical Power", 1, c_black, 10, 1, 1, 0)
			draw_text_outlined(other.x+other.offset+5, other.y+other.height-18-between*3, "Attack Speed", 1, c_black, 10, 0.9, 0.9, 0)
			draw_text_outlined(other.x+other.offset+5, other.y+other.height-18-between*2, "Magical Power", 1, c_black, 10, 1, 1, 0)
			draw_text_outlined(other.x+other.offset+5, other.y+other.height-18-between, "Movement Speed", 1, c_black, 10, 0.9, 0.9, 0)
		}
		draw_text_outlined(x+offset+5, y+height-18, "Gold", 1, c_black, 10, 1, 1, 0)
	draw_set_color(c_ltgray) draw_set_halign(fa_right)
	
		if (global.clientName != undefined) {
			draw_text_outlined(x+width-offset-10, y+height_ext_top+offset+offset+18, global.clientName, 1, c_black, 10, 0.8, 0.8, 0)
			draw_text_outlined(x+width-offset-10, y+height_ext_top+offset+offset+18+between, global.clientClass, 1, c_black, 10, 0.8, 0.8, 0)
			draw_text_outlined(x+width-offset-10, y+height_ext_top+offset+offset+18+between*2, global.level, 1, c_black, 10, 0.8, 0.8, 0)
		}
	
		with (objPlayer) {
			draw_text_outlined(other.x+other.width-other.offset-10, other.y+other.height-18-between*4, string(physicalPower), 1, c_black, 10, 1, 1, 0)
			draw_text_outlined(other.x+other.width-other.offset-10, other.y+other.height-18-between*3, string(attackSpeed)+"h/s", 1, c_black, 10, 0.9, 0.9, 0)
			draw_text_outlined(other.x+other.width-other.offset-10, other.y+other.height-18-between*2, string(magicalPower), 1, c_black, 10, 1, 1, 0)
			draw_text_outlined(other.x+other.width-other.offset-10, other.y+other.height-18-between, string(movementSpeed/10), 1, c_black, 10, 1, 1, 0)
		}
		draw_text_outlined(x+width-offset-10, y+height-18, global.gold, 1, c_black, 10, 0.8, 0.8, 0)
	draw_set_default()
}

draw_set_alpha(1)

event_inherited()