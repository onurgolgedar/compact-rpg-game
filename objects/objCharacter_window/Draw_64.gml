var mouseOnBody = is_mouse_on()

draw_set_color(c_white) draw_set_alpha(0.9*image_alpha)
	draw_set_color(c_windowback)
		draw_roundrect_ext(x-offset, y-offset, x+width+offset, y+height+offset, 17, 17, 0)
	draw_set_color(onFront ? c_window : c_dkgray) draw_set_alpha(0.38*image_alpha)
		draw_roundrect_ext(x, y+height_ext_top+offset, x+width, y+height, 17, 17, 0)
		draw_roundrect_ext(x+offset, y+height_ext_top+offset+offset, x+width-offset, y+height-offset, 17, 17, 0)

		draw_roundrect_ext(x, y, x+width, y+height_ext_top/2-offset/2, 17, 17, 0)
		/*draw_set_color(c_dkivory) draw_set_alpha(0.07*image_alpha)
			draw_roundrect_ext(x+offset, y+height_ext_top+offset+offset, x+width/2+offset*3, y+height-offset, 17, 17, 0)
		draw_set_color(c_white)
			draw_roundrect_ext(x+width/2+offset*4, y+height_ext_top+offset+offset, x+width-offset, y+height-offset, 17, 17, 0)*/
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
		draw_set_color(page-1 == i ? c_gray : c_dkgray)
     
	var beforeColor = draw_get_color()
	draw_set_color(c_black)
		draw_roundrect(pageButton_x[i]-2, pageButton_y[i]-2,
		pageButton_x[i]+pageButtonEdge*pageButtonWidthFactor+2, pageButton_y[i]+pageButtonEdge+2, 0)
	draw_set_color(beforeColor)	
		draw_roundrect(pageButton_x[i], pageButton_y[i],
		pageButton_x[i]+pageButtonEdge*pageButtonWidthFactor, pageButton_y[i]+pageButtonEdge, 0)
	draw_set_color(c_white)
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
	draw_set_alpha(0.2*image_alpha)
		draw_roundrect(x+offset+1, y+height_ext_top+offset+offset+18-7, x+width-offset-2, y+height_ext_top+offset+offset+18+10, 0)
		draw_roundrect(x+offset+1, y+height_ext_top+offset+offset+18+between-7, x+width-offset-2, y+height_ext_top+offset+offset+between+18+10, 0)
		draw_roundrect(x+offset+1, y+height_ext_top+offset+offset+18+between*2-7, x+width-offset-2, y+height_ext_top+offset+offset+between*2+18+10, 0)
		
		draw_roundrect(x+offset+2, y+height_ext_top+offset+offset+18-6, x+width-offset-3, y+height_ext_top+offset+offset+18+9, 0)
		draw_roundrect(x+offset+2, y+height_ext_top+offset+offset+18+between-6, x+width-offset-3, y+height_ext_top+offset+offset+between+18+9, 0)
		draw_roundrect(x+offset+2, y+height_ext_top+offset+offset+18+between*2-6, x+width-offset-3, y+height_ext_top+offset+offset+between*2+18+9, 0)
		
		with (objPlayer) {
			draw_roundrect(other.x+other.offset+1, other.y+other.height-18-between*4-7, other.x+other.width-other.offset-2, other.y+other.height-18-between*4+10, 0)
			draw_roundrect(other.x+other.offset+1, other.y+other.height-18-between*3-7, other.x+other.width-other.offset-2, other.y+other.height-18-between*3+10, 0)
			draw_roundrect(other.x+other.offset+1, other.y+other.height-18-between*2-7, other.x+other.width-other.offset-2, other.y+other.height-18-between*2+10, 0)
			draw_roundrect(other.x+other.offset+1, other.y+other.height-18-between-7, other.x+other.width-other.offset-2, other.y+other.height-18-between+10, 0)
			
			draw_roundrect(other.x+other.offset+2, other.y+other.height-18-between*4-6, other.x+other.width-other.offset-3, other.y+other.height-18-between*4+9, 0)
			draw_roundrect(other.x+other.offset+2, other.y+other.height-18-between*3-6, other.x+other.width-other.offset-3, other.y+other.height-18-between*3+9, 0)
			draw_roundrect(other.x+other.offset+2, other.y+other.height-18-between*2-6, other.x+other.width-other.offset-3, other.y+other.height-18-between*2+9, 0)
			draw_roundrect(other.x+other.offset+2, other.y+other.height-18-between-6, other.x+other.width-other.offset-3, other.y+other.height-18-between+9, 0)
		}
		
	draw_roundrect(x+offset+1, y+height-18-7, x+width-offset-4, y+height-18+10, 0)
	draw_roundrect(x+offset+2, y+height-18-6, x+width-offset-3, y+height-18+9, 0)
	draw_set_alpha(1*image_alpha)
	
	draw_set_color(c_white) draw_set_font(fontMain)
		draw_text_outlined(x+offset+5, y+height_ext_top+offset+offset+18, "NAME", 1, c_black, 10, 0.9, 0.9, 0)
		draw_text_outlined(x+offset+5, y+height_ext_top+offset+offset+18+between, "CLASS", 1, c_black, 10, 0.9, 0.9, 0)
		draw_text_outlined(x+offset+5, y+height_ext_top+offset+offset+18+between*2, "LEVEL", 1, c_black, 10, 0.9, 0.9, 0)
	
		with (objPlayer) {
			draw_text_outlined(other.x+other.offset+5, other.y+other.height-18-between*4, "PHY POWER", 1, c_black, 10, 0.9, 0.9, 0)
			draw_text_outlined(other.x+other.offset+5, other.y+other.height-18-between*3, "ATTACK SPEED", 1, c_black, 10, 0.9, 0.9, 0)
			draw_text_outlined(other.x+other.offset+5, other.y+other.height-18-between*2, "MAG POWER", 1, c_black, 10, 0.9, 0.9, 0)
			draw_text_outlined(other.x+other.offset+5, other.y+other.height-18-between, "MOVEMENT", 1, c_black, 10, 0.9, 0.9, 0)
		}
		draw_text_outlined(x+offset+5, y+height-18, "GOLD", 2, c_black, 10, 0.9, 0.9, 0)
		draw_set_halign(fa_right) draw_set_font(fontMain)
	
		if (global.clientName != undefined) {
			draw_text_outlined(x+width-offset-10, y+height_ext_top+offset+offset+18, global.clientName, 1, c_black, 10, 0.87, 0.87, 0)
			draw_text_outlined(x+width-offset-10, y+height_ext_top+offset+offset+18+between, global.clientClass, 1, c_black, 10, 0.87, 0.87, 0)
			draw_text_outlined(x+width-offset-10, y+height_ext_top+offset+offset+18+between*2, global.level, 1, c_black, 10, 0.87, 0.87, 0)
		}
	
		with (objPlayer) {
			draw_text_outlined(other.x+other.width-other.offset-10, other.y+other.height-18-between*4, string(physicalPower), 1, c_black, 10, 0.87, 0.87, 0)
			draw_text_outlined(other.x+other.width-other.offset-10, other.y+other.height-18-between*3, string(attackSpeed)+"h/s", 1, c_black, 10, 0.87, 0.87, 0)
			draw_text_outlined(other.x+other.width-other.offset-10, other.y+other.height-18-between*2, string(magicalPower), 1, c_black, 10, 0.87, 0.87, 0)
			draw_text_outlined(other.x+other.width-other.offset-10, other.y+other.height-18-between, string(movementSpeed/10), 1, c_black, 10, 0.87, 0.87, 0)
		}
		draw_text_outlined(x+width-offset-10, y+height-18, global.gold, 1, c_black, 10, 0.9, 0.9, 0)
	draw_set_default()
}

draw_set_alpha(1)

event_inherited()