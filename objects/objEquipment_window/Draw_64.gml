draw_set_color(c_white) draw_set_alpha(0.4)
	draw_set_color(c_black)
		draw_roundrect_ext(x-offset, y-offset, x+width+offset, y+height+offset, 15, 15, 0)
	draw_set_color(COLOR_WINDOW)
		draw_roundrect_ext(x, y+height_ext_top+offset, x+width, y+height, 15, 15, 0)
		draw_roundrect_ext(x+offset, y+height_ext_top+offset+offset, x+width-offset, y+height-height_ext_bot-offset-height_ext_bot_more, 15, 15, 0)
	draw_set_color(COLOR_WINDOW)
		draw_roundrect_ext(x, y, x+width, y+height_ext_top, 15, 15, 0)
		
	/*draw_set_color(c_white)
		draw_roundrect_ext(x+offset, y+height-height_ext_bot-height_ext_bot_more, x+width-offset, y+height-offset-height_ext_bot_more, 15, 15, 0)
		draw_roundrect_ext(x+offset, y+height-offset-height_ext_bot_more+offset, x+width-offset, y+height-offset, 15, 15, 0)*/
	
	draw_set_color(c_white) draw_set_alpha(1) draw_set_font(fontWindowTitle) draw_set_center()
		draw_text_outlined(x+width/2, y+height_ext_top/2, title, 2, c_black, 10, 1, 1, 0)
		
	for (var i = 0; i < global.bc_hor_COMMON; i++) {
		for (var j = global.bc_ver_COMMON; j < global.bc_ver_COMMON+1; j++) {
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
		
	for (var i = 0; i < global.bc_hor_COMMON; i++) {
		for (var j = global.bc_ver_COMMON; j < global.bc_ver_COMMON+1; j++) {
			var box_positions = get_box_positions(i, j)
			var box = ds_grid_get(boxes, i, j)
			
			draw_set_alpha(1)
			if (box.item != undefined) {			
				var item_xx = (box_positions.xx_start+box_positions.xx_end)/2
				var item_yy = (box_positions.yy_start+box_positions.yy_end)/2
				
				if (i != held_box_i or j != held_box_j)  {
					draw_outline_origin(box.item.sprite, -1, item_xx, item_yy, 0.47, 0.47, 60, boxes_alpha[i][j])
					draw_sprite_origin_ext(box.item.sprite, -1, item_xx, item_yy, 0.47, 0.47, 60, c_white, boxes_alpha[i][j])
				}
			}
		}
	}
	
	if (held_box != undefined) {
		draw_outline_origin(held_box.item.sprite, -1, global.dmx, global.dmy, 0.47, 0.47, 60, 1)
		draw_sprite_origin_ext(held_box.item.sprite, -1, global.dmx, global.dmy, 0.47, 0.47, 60, c_white, 1)
	}
draw_set_default() draw_set_alpha(1)

event_inherited()