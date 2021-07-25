var mouseOnBody = is_mouse_on()

draw_set_color(c_white) draw_set_alpha(0.9)
	draw_set_color(COLOR_WINDOW_BACK)
		draw_roundrect_ext(x-offset, y-offset, x+width+offset, y+height+offset, 15, 15, 0)
	draw_set_color(onFront ? COLOR_WINDOW : c_dkgray) draw_set_alpha(0.43)
		draw_roundrect_ext(x, y+height_ext_top+offset, x+width, y+height, 15, 15, 0)
		draw_roundrect_ext(x+offset, y+height_ext_top+offset+offset, x+width-offset, y+height-height_ext_bot-offset-height_ext_bot_more, 15, 15, 0)
	draw_set_color(onFront ? COLOR_WINDOW : c_dkgray)
		draw_roundrect_ext(x, y, x+width, y+height_ext_top/2-offset/2, 15, 15, 0)
	draw_set_alpha(1) draw_set_color(c_black)
	//draw_roundrect(x-offset, y-offset, x+width+offset, y+height+offset, 1)
		
	draw_set_color(c_white) draw_set_alpha(0.4)
		draw_roundrect_ext(x+offset, y+height-height_ext_bot-height_ext_bot_more, x+width-offset, y+height-offset-height_ext_bot_more, 15, 15, 0)
		draw_roundrect_ext(x+offset, y+height-offset-height_ext_bot_more+offset, x+width-offset, y+height-offset, 15, 15, 0)
	
	draw_set_color(c_white) draw_set_alpha(1) draw_set_font(fontWindowTitle) draw_set_center()
		draw_text_outlined(x+width/2, y+(height_ext_top/2-offset/2)/2+2, title, 2, c_black, 10, 0.7, 0.7, 0)
	
	mouseOnButton = undefined
	var pageButtonEdge = 22
	var pageButton_x, pageButton_y
	for (var i = 0; i < pageCount; i++) {
		draw_set_alpha(1)
		pageButton_x[i] = x+offset+i*(offset*2+pageButtonEdge)
		pageButton_y[i] = y+(height_ext_top/2-offset/2)/2+pageButtonEdge/2+offset*2
    
		if (mouseOnBody and global.dmx > pageButton_x[i] and global.dmx < pageButton_x[i]+pageButtonEdge and
			global.dmy > pageButton_y[i] and global.dmy < pageButton_y[i]+pageButtonEdge and !is_click_blocked()) {
		    draw_set_color(c_lime)
		    mouseOnButton = i
		}
		else
			draw_set_color(page-1 == i ? c_ltgray : c_dkgray)
     
		var beforeColor = draw_get_color()
		draw_set_color(c_black)
			draw_roundrect(pageButton_x[i]-2, pageButton_y[i]-2,
			pageButton_x[i]+pageButtonEdge+2, pageButton_y[i]+pageButtonEdge+2, 0)
		draw_set_color(beforeColor)	
			draw_roundrect(pageButton_x[i], pageButton_y[i],
			pageButton_x[i]+pageButtonEdge, pageButton_y[i]+pageButtonEdge, 0)
		draw_set_color(c_black)
		draw_set_alpha(1)
    
		draw_set_center() draw_set_font(fontMain)
		    draw_text(pageButton_x[i]+pageButtonEdge/2, pageButton_y[i]+pageButtonEdge/2+2, string(i+1))
		draw_set_default()
	}
	
	var button_x = x+offset*2
	var button_y = y+height-offset-height_ext_bot_more+offset*2
	var button_width = 130
	var button_height = 30
	draw_set_alpha(1)
	if (mouseOnBody and global.dmx > button_x and global.dmx < button_x+button_width and
		global.dmy > button_y and global.dmy < button_y+button_height and !is_click_blocked()) {
		draw_set_color(!instance_exists(objEquipments_window) ? c_lime : c_red)
		mouseOnButton = 100
	}
	else
		draw_set_color(c_dkgray)
	beforeColor = draw_get_color()
	draw_set_color(c_black)
		draw_roundrect(button_x-2, button_y-2,
		button_x+button_width+2, button_y+button_height+2, 0)
	draw_set_color(beforeColor)	
		draw_roundrect(button_x, button_y,
		button_x+button_width, button_y+button_height, 0)
	draw_set_color(c_black)
	draw_set_alpha(1)

	
	draw_set_center() draw_set_font(fontMain)
		draw_text(button_x+button_width/2, button_y+button_height/2+2, "Equipments")
	
		draw_sprite(sprCoin, -1, x+width-offset-100, button_y+button_height/2+2)
	draw_set_default()
	draw_text(x+width-offset-85, button_y+3, real(global.gold))
	
	for (var i = global.bc_hor_COMMON*(page-1); i < global.bc_hor_COMMON*page; i++) {
		for (var j = 0; j < global.bc_ver_COMMON; j++) {
			var box_positions = get_box_positions(i, j)
			var box = ds_grid_get(boxes, i, j)
			
			var beforeColor = draw_get_color()
			if (box.tag.isActive)
				draw_set_color(c_yellow)
			draw_set_alpha(1)
			draw_sprite(sprCell, 0, box_positions.xx_center, box_positions.yy_center)
			draw_set_color(beforeColor)
			
		}
	}
		
	for (var i = global.bc_hor_COMMON*(page-1); i < global.bc_hor_COMMON*page; i++) {
		for (var j = 0; j < global.bc_ver_COMMON; j++) {
			var box_positions = get_box_positions(i, j)
			var box = ds_grid_get(boxes, i, j)
			
			draw_set_alpha(1)
			if (box.item != undefined) {			
				var item_xx = (box_positions.xx_start+box_positions.xx_end)/2
				var item_yy = (box_positions.yy_start+box_positions.yy_end)/2
				
				if (i != global.held_box_i or j != global.held_box_j)  {
					draw_outline_origin(box.item.sprite, -1, item_xx, item_yy, 0.47, 0.47, 60, boxes_alpha[i][j])
					draw_sprite_origin_ext(box.item.sprite, -1, item_xx, item_yy, 0.47, 0.47, 60, c_white, boxes_alpha[i][j])
				}
			}
		}
	}
draw_set_default() draw_set_alpha(1)

event_inherited()