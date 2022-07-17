var mouseOnBody = is_mouse_on()

draw_set_color(c_white) draw_set_alpha(0.9*image_alpha)
	draw_set_color(c_windowback)
		draw_roundrect_ext(x-offset, y-offset, x+width+offset, y+height+offset, 15, 15, 0)
	draw_set_color(onFront ? c_window : c_dkgray) draw_set_alpha(0.38*image_alpha)
		draw_roundrect_ext(x, y+height_ext_top+offset, x+width, y+height, 15, 15, 0)

		draw_roundrect_ext(x, y, x+width, y+height_ext_top/2-offset/2, 15, 15, 0)
draw_set_default() draw_set_alpha(1*image_alpha)

draw_set_color(c_white) draw_set_alpha(1*image_alpha) draw_set_font(fontWindowTitle) draw_set_center()
	draw_text_outlined(x+width/2, y+(height_ext_top/2-offset/2)/2+2, title, 2, c_black, 10, 1, 1, 0)
draw_set_default()

mouseOnButton = undefined

// Page Buttons
var pageButtonEdge = 20
var pageButtonWidthFactor = 2
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
		draw_text(pageButton_x[i]+pageButtonEdge*pageButtonWidthFactor/2, pageButton_y[i]+pageButtonEdge/2+2, string(i+1))
	draw_set_default()
}

if (prepDone) {
	draw_set_color(c_white) draw_set_font(fontGUi_small)
	var ds_size = ds_map_size(global.activeQuests_player)
	var ds_keys = ds_map_keys_to_array(global.activeQuests_player)
	for (var i = (page-1)*6; i < ds_size and i < page*6; i++) {
		var activeQuest = global.activeQuests_player[? ds_keys[i]]
		
		var offset_y = (i mod 6)*52
		var xx = x+offset+7
		var yy = y+height_ext_top+offset+offset+18+offset_y
		var _width = width-xx*2+2*x
		var _height = 35
	
		if (mouseOnBody and global.dmx > xx and global.dmx < xx+_width and
			global.dmy > yy and global.dmy < yy+_height and !is_click_blocked()) {
			draw_set_color(c_lime)
			mouseOnButton = 100+i
		}
		else
			draw_set_color(c_gray)
	
		draw_set_alpha(0.4*image_alpha)
			draw_roundrect(xx-5, yy-5, xx+_width+5, yy+5+_height, 0)
			draw_roundrect(xx-5+2, yy-5+2, xx+_width+5-2, yy+5+_height-2, 0)
		draw_set_alpha(1*image_alpha) draw_set_color(c_white)
	
		draw_text_outlined(xx, yy-2, activeQuest.title, 1, c_black, 14, 1.2, 1.2, 0)
		var shortDesc = activeQuest.shortDescription
		if (shortDesc != undefined)
			draw_text_outlined(xx, yy+22, shortDesc, 1, c_black, 14, 1, 1, 0)
	}
	draw_set_color(c_black) draw_set_font(fontMain)
}
	
draw_set_alpha(1)
event_inherited()