var mouseOnBody = is_mouse_on()
var isDialogue = (dialogueOrderText != "")
var mainAlpha = 0.9*image_alpha

if (onFront and isDialogue) {
	draw_set_alpha(0.55*mainAlpha)
		draw_rectangle(-1, -1, display_get_gui_width(), display_get_gui_height(), 0)
}

draw_set_color(c_white) draw_set_alpha(mainAlpha)
	draw_set_color(c_windowback)
		draw_roundrect_ext(x-offset, y-offset, x+width+offset, y+height+offset, 17, 17, 0)
	draw_set_color(onFront ? c_gray : c_dkgray) draw_set_alpha(mainAlpha/9)
		draw_roundrect_ext(x, y, x+width, y+height, 17, 17, 0)
draw_set_default() draw_set_alpha(mainAlpha)

// Buttons
var ds_size_buttons = ds_list_size(buttons)
if (ds_size_buttons > 0) {
	buttonHovered_index = -1
	
	if (buttonMaxPage > 1) {
		var upButton_xx_st = x+upButton_xx_rel+offset-width/2
		var upButton_xx_en = x+upButton_xx_rel+width/2-offset
		var downButton_xx_st = x+downButton_xx_rel+offset-width/2
		var downButton_xx_en = x+downButton_xx_rel+width/2-offset
		var upButton_yy_st = y+upButton_yy_rel-upButton_height/2
		var upButton_yy_en = y+upButton_yy_rel+upButton_height/2
		var downButton_yy_st = y+downButton_yy_rel-downButton_height/2
		var downButton_yy_en = y+downButton_yy_rel+downButton_height/2
		
		if (global.dmx > upButton_xx_st and global.dmx < upButton_xx_en and global.dmy > upButton_yy_st and global.dmy < upButton_yy_en) {
			draw_set_color(c_aqua)
			buttonHovered_index = -1000
		}
		else if (global.dmx > downButton_xx_st and global.dmx < downButton_xx_en and global.dmy > downButton_yy_st and global.dmy < downButton_yy_en) {
			draw_set_color(c_aqua)
			buttonHovered_index = 1000
		}
		
		draw_set_alpha(0.45*mainAlpha)
		draw_set_color((buttonPage > 1) ? (buttonHovered_index == -1000 ? c_aqua : c_gray) : c_dkgray)
			draw_roundrect_ext(x+upButton_xx_rel+offset-width/2, y+upButton_yy_rel-upButton_height/2, x+upButton_xx_rel+width/2-offset, y+upButton_yy_rel+upButton_height/2, 10, 10, 0)
		draw_set_color((buttonPage < buttonMaxPage) ? (buttonHovered_index == 1000 ? c_aqua : c_gray) : c_dkgray) 
			draw_roundrect_ext(x+downButton_xx_rel+offset-width/2, y+downButton_yy_rel-downButton_height/2, x+downButton_xx_rel+width/2-offset, y+downButton_yy_rel+downButton_height/2, 10, 10, 0)
		draw_set_color(c_ltgray) draw_set_alpha(mainAlpha)
		draw_set_center()
			draw_text_outlined(x+upButton_xx_rel, y+upButton_yy_rel, "▲", 1, c_black, 0, 1, 1, 0)
			draw_text_outlined(x+downButton_xx_rel, y+downButton_yy_rel, "▼", 1, c_black, 0, 1, 1, 0)
		draw_set_default()
	}
		
	draw_set_center()
	for (var i = (buttonPage-1)*buttonMaxCount_perPage; i < min(buttonMaxCount_perPage*buttonPage, buttonCount); i++) {
		draw_set_color(c_gray) draw_set_alpha(0.45*mainAlpha)
		var button = ds_list_find_value(buttons, i)
		var buttonLocation = get_button_location(i)
		
		if (global.dmx > buttonLocation.xx-buttonWidth/2 and global.dmx < buttonLocation.xx+buttonWidth/2 and global.dmy > buttonLocation.yy-buttonHeight/2 and global.dmy < buttonLocation.yy+buttonHeight/2) {
			button.hover = true
			draw_set_color(c_aqua)
			buttonHovered_index = i
		}
		else
			button.hover = false
		
		draw_roundrect_ext(buttonLocation.xx-buttonWidth/2, buttonLocation.yy-buttonHeight/2, buttonLocation.xx+buttonWidth/2, buttonLocation.yy+buttonHeight/2, 17, 17, 0)
		
		draw_set_color(c_white) draw_set_alpha(mainAlpha)
			draw_text_outlined(buttonLocation.xx, buttonLocation.yy+2, button.text, 1, c_black, 10, 0.8, 0.8, 0)
		if (button.image != undefined)
			draw_sprite_ext(button.image, -1, buttonLocation.xx+buttonWidth/2-14, buttonLocation.yy, 1, 1, 0, c_white, mainAlpha)
	}
	draw_set_default()
}

if (dialogueOrderText != undefined) {
	draw_set_color(c_aqua) draw_set_halign(fa_right)
		draw_text_outlined(x+width-20-offset*2, y+offset, dialogueOrderText, 1, c_black, 15, 1, 1, 0)
	draw_set_default()
}

draw_set_color(c_gray) draw_set_font(fontWindowTitle)
	draw_text_outlined(x+offset, y+offset, title, 1, c_black, 15, 1, 1, 0)
draw_set_default()

if (duration > 0) {
	var durationBarColor = (alarm[1] > 1 or isHeld) ? c_aqua : c_ltyellow
	draw_set_alpha(mainAlpha*(1-0.4*(duration > maxDuration)))
		draw_roundrect(x-offset, y-12, x+width+offset, y, 0)
    draw_set_color(durationBarColor) 
        draw_roundrect(x-offset+3, y-10, x+3+min(duration/maxDuration, 1)*(width+offset-6), y-2, 0)
	draw_set_color(c_black) draw_set_alpha(1)
}

/**/

event_inherited()