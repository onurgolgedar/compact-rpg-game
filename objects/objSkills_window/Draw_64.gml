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
		draw_roundrect_ext(x+offset, y+height-height_ext_bot-height_ext_bot_more, x+width-offset, y+height-offset-height_ext_bot_more, 17, 17, 0)
	
	draw_set_color(c_white) draw_set_alpha(1*image_alpha) draw_set_font(fontWindowTitle) draw_set_center()
		draw_text_outlined(x+width/2, y+(height_ext_top/2-offset/2)/2+2, title, 2, c_black, 10, 1, 1, 0)
	draw_set_default()
		
	draw_text(x+width-offset-35, y+height-offset-height_ext_bot/2+3-13, global.skillPoints)
	
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
	
	for (var i = global.sc_hor_COMMON*(page-1); i < global.sc_hor_COMMON*page; i++) {
		for (var j = 0; j < global.sc_ver_COMMON; j++) {
			var box_positions = get_box_positions(i, j)
			var box = ds_grid_get(boxes, i, j)
			
			/*if (box.skill != undefined)
				draw_sprite_ext(sprCell, 11, box_positions.xx_center, box_positions.yy_center, 0.95, 0.7, 0, c_white, 0.25)*/
		}
	}
		
	for (var i = global.sc_hor_COMMON*(page-1); i < global.sc_hor_COMMON*page; i++) {
		for (var j = 0; j < global.sc_ver_COMMON; j++) {
			var box_positions = get_box_positions(i, j)
			var box = ds_grid_get(boxes, i, j)
			
			draw_set_alpha(1*image_alpha)
			if (box.skill != undefined) {			
				var skill_xx = (box_positions.xx_start+box_positions.xx_end)/2
				var skill_yy = (box_positions.yy_start+box_positions.yy_end)/2
				
				/*draw_set_color(c_black) draw_set_alpha(1*image_alpha)
					draw_roundrect(box_positions.xx_start, box_positions.yy_start-8,
					box_positions.xx_end+90, box_positions.yy_end+8, 0)*/
				draw_set_color(c_hardgray) draw_set_alpha(0.8*image_alpha)
					draw_roundrect(box_positions.xx_start+1, box_positions.yy_start-6,
					box_positions.xx_end-2+90, box_positions.yy_end+6, 0)
					
				draw_set_color(c_dkivory) draw_set_alpha(0.8*image_alpha)
					draw_roundrect(box_positions.xx_end-2, box_positions.yy_start-4,
					box_positions.xx_end-4+90, box_positions.yy_end+4, 0)
				draw_set_color(c_ivory) draw_set_alpha(0.8*image_alpha)
					draw_roundrect(box_positions.xx_start+4, box_positions.yy_start-4,
					box_positions.xx_end-4, box_positions.yy_end+4, 0)
				if (!onFront) {
					draw_set_color(c_black) draw_set_alpha(0.25*image_alpha)
						draw_roundrect(box_positions.xx_end-2, box_positions.yy_start-4,
						box_positions.xx_end-4+90, box_positions.yy_end+4, 0)
					draw_set_color(c_black) draw_set_alpha(0.25*image_alpha)
						draw_roundrect(box_positions.xx_start+4, box_positions.yy_start-4,
						box_positions.xx_end-4, box_positions.yy_end+4, 0)
				}
				
				draw_set_color(c_black) draw_set_alpha(1*image_alpha)
				
				draw_sprite_ext(box.skill.sprite, -1, skill_xx, skill_yy, 0.8, 0.8, 0, c_black, 0.7*image_alpha)
				if (i != global.held_box_i or j != global.held_box_j or global.held_from_assetName != object_get_name(object_index)) 
					draw_sprite_ext(box.skill.sprite, -1, skill_xx, skill_yy, 0.73, 0.73, 0, c_white, 1*image_alpha)
				draw_set_center() draw_set_color(c_ltlime) draw_set_font(fontGUi_small_b)
					if (box.skill.upgrade > 0)
						draw_text_outlined(skill_xx+boxWidth/2-17, skill_yy+boxHeight/2-5, "+"+string(box.skill.upgrade), 1, c_hardgray, 20, 1, 1, 0)
				draw_set_default()
				
				// Button
				var button_x = skill_xx+35
				var button_y = skill_yy-20
				var buttonWidth = 75
				var buttonHeight = 16
				if (mouseOnBody and global.dmx > button_x and global.dmx < button_x+buttonWidth and
					global.dmy > button_y and global.dmy < button_y+buttonHeight and !is_click_blocked()) {
				    draw_set_color(global.skillPoints == 0 ? c_gray : make_color_rgb(40, 200, 40))
					if (global.skillPoints > 0)
						mouseOnButton = 1000000+i+j/100
				}
				else
					draw_set_color(global.skillPoints == 0 ? c_dkgray : make_color_rgb(25, 100, 25))
     
				var beforeColor = draw_get_color()
				draw_set_color(c_hardgray)
					draw_roundrect(button_x-2, button_y-2,
					button_x+buttonWidth+2, button_y+buttonHeight+2, 0)
				draw_set_color(beforeColor)	
					draw_roundrect(button_x, button_y,
					button_x+buttonWidth, button_y+buttonHeight, 0)
				draw_set_color(c_white)
				draw_set_alpha(1*image_alpha)
    
				draw_set_center() draw_set_font(fontGUi_small)
				    draw_text_transformed(button_x+buttonWidth/2, button_y+buttonHeight/2+1, "Upgrade", 0.96, 0.96, 0)
				draw_set_default()
				
				// Button
				var button_x = skill_xx+35
				var button_y = skill_yy+4
				var buttonWidth = 75
				var buttonHeight = 16
				if (mouseOnBody and global.dmx > button_x and global.dmx < button_x+buttonWidth and
					global.dmy > button_y and global.dmy < button_y+buttonHeight and !is_click_blocked()) {
				    draw_set_color(box.skill.upgrade == 0 ? c_gray : make_color_rgb(200, 40, 40))
					if (box.skill.upgrade > 0)
						mouseOnButton = 2000000+i+j/100
				}
				else
					draw_set_color(box.skill.upgrade == 0 ? c_dkgray : make_color_rgb(100, 25, 25))
     
				var beforeColor = draw_get_color()
				draw_set_color(c_hardgray)
					draw_roundrect(button_x-2, button_y-2,
					button_x+buttonWidth+2, button_y+buttonHeight+2, 0)
				draw_set_color(beforeColor)	
					draw_roundrect(button_x, button_y,
					button_x+buttonWidth, button_y+buttonHeight, 0)
				draw_set_color(c_white)
				draw_set_alpha(1*image_alpha)
    
				draw_set_center() draw_set_font(fontGUi_small)
				    draw_text_transformed(button_x+buttonWidth/2, button_y+buttonHeight/2+1, "Drop", 0.96, 0.96, 0)
				draw_set_default()
			}
		}
	}
draw_set_default() draw_set_alpha(1)

event_inherited()