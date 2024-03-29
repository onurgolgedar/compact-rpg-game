var mouseOnBody = is_mouse_on()

draw_set_color(c_white) draw_set_alpha(0.9*image_alpha)
	draw_set_color(c_windowback)
		draw_roundrect_ext(x-offset, y-offset, x+width+offset, y+height+offset, 17, 17, 0)
	draw_set_color(onFront ? c_window : c_dkgray) draw_set_alpha(0.38*image_alpha)
		draw_roundrect_ext(x, y+height_ext_top+offset, x+width, y+height, 17, 17, 0)
		draw_roundrect_ext(x+offset, y+height_ext_top+offset+offset, x+width-offset, y+height-height_ext_bot-offset-height_ext_bot_more, 17, 17, 0)
		
		draw_roundrect_ext(x, y, x+width, y+height_ext_top/2-offset/2, 17, 17, 0)
	draw_set_alpha(1*image_alpha) draw_set_color(c_black)
	//draw_roundrect(x-offset, y-offset, x+width+offset, y+height+offset, 1)
		
	draw_set_color(c_white) draw_set_alpha(0.4*image_alpha)
		if (height_ext_bot != 0)
			draw_roundrect_ext(x+offset, y+height-height_ext_bot-height_ext_bot_more, x+width-offset, y+height-offset-height_ext_bot_more, 17, 17, 0)
		if (height_ext_bot_more != 0)
			draw_roundrect_ext(x+offset, y+height-offset-height_ext_bot_more+offset, x+width-offset, y+height-offset, 17, 17, 0)
	
	draw_set_color(c_white) draw_set_alpha(1*image_alpha) draw_set_font(fontWindowTitle) draw_set_center()
		draw_text_outlined(x+width/2, y+(height_ext_top/2-offset/2)/2+2, title, 2, c_black, 10, 1, 1, 0)
	
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
		    draw_text(pageButton_x[i]+pageButtonEdge*pageButtonWidthFactor/2, pageButton_y[i]+pageButtonEdge/2+2, string(i+1))
		draw_set_default()
	}
	
	for (var i = global.bc_hor_COMMON*(page-1); i < global.bc_hor_COMMON*page; i++) {
		for (var j = 0; j < global.bc_ver_COMMON; j++) {
			var box_positions = get_box_positions(i, j)
			var box = ds_grid_get(boxes, i, j)
			
			draw_sprite(sprCell, 0, box_positions.xx_center, box_positions.yy_center)			
		}
	}
		
	for (var i = global.bc_hor_COMMON*(page-1); i < global.bc_hor_COMMON*page; i++) {
		for (var j = 0; j < global.bc_ver_COMMON; j++) {
			var box_positions = get_box_positions(i, j)
			var box = ds_grid_get(boxes, i, j)
			
			draw_set_alpha(1*image_alpha)
			if (box.item != undefined) {			
				var item_xx = (box_positions.xx_start+box_positions.xx_end)/2
				var item_yy = (box_positions.yy_start+box_positions.yy_end)/2
				
				if (i != global.held_box_i or j != global.held_box_j or global.held_from_assetName != object_get_name(object_index))  {
					draw_outline_origin(box.item.sprite, -1, item_xx, item_yy, 0.47, 0.47, 60, boxes_alpha[i][j]*image_alpha)
					draw_sprite_origin_ext(box.item.sprite, -1, item_xx, item_yy, 0.47, 0.47, 60, c_white, boxes_alpha[i][j]*image_alpha)
				}
			}
		}
	}
	
draw_set_default() draw_set_alpha(1)

event_inherited()