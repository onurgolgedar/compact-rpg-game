if (!is_in_game_room_COMMON())
	exit

if (is_alive()) {
	with (objPlayer) {
		var ds_size = ds_list_size(effectBoxes)
		if (ds_size == 0) {
			if (other.effectBox_textbox != undefined)
				instance_destroy(other.effectBox_textbox)
		}
		
		var beforeMouseOn = other.mouseOn_effectBox
		 other.mouseOn_effectBox = undefined
		for (var i = 0; i < ds_size; i++) {
			var effectBox = effectBoxes[| i]
			
			var xx = 30+i*55
			var yy = 40
			
			if ((device_mouse_y_to_gui(0) < yy+22 and device_mouse_x_to_gui(0) > xx-22 and device_mouse_x_to_gui(0) < xx+22 and device_mouse_y_to_gui(0) > 8) and !is_click_blocked()) {
				other.mouseOn_effectBox = effectBox
				
				if (device_mouse_check_button_pressed(0, mb_left) and other.mouseOn_effectBox.isDeletable) {
					var buttonsArray = [ new st_dialogueButton("Clear", undefined, { order: i, effectBox: effectBox }), new st_dialogueButton("Cancel") ]
					var dialogue_box = show_questionbox(15, 250, other.mouseOn_effectBox.name, "Do you want to clear this effect?", real(other.id), 1, buttonsArray)
				}
			}
			
			draw_sprite(sprEffectBoxBackground, -1, xx, yy)
			draw_sprite(effectBox.sprite, -1, xx, yy)

			if (effectBox.time > 0)
				draw_sprite_general(sprEffectBoxBackground, 1, 0, 0, sprite_get_width(sprEffectBoxBackground), sprite_get_height(sprEffectBoxBackground)*effectBox.time/effectBox.maxTime, xx-sprite_get_width(sprEffectBoxBackground)/2, 40-sprite_get_height(sprEffectBoxBackground)/2, 1, 1, 0, c_white, c_white, c_white, c_white, image_alpha)
		}
		
		if (!effectBox_is_equal_COMMON(other.mouseOn_effectBox, beforeMouseOn)) {				
			if (other.mouseOn_effectBox != undefined and beforeMouseOn == undefined) {
				if (other.effectBox_textbox != undefined)
					instance_destroy(other.effectBox_textbox)
				other.effectBox_textbox = create_textbox(other.mouseOn_effectBox.description, real(contCursor.id))
			}
			else if (other.mouseOn_effectBox == undefined and beforeMouseOn != undefined) {
				if (other.effectBox_textbox != undefined)
					instance_destroy(other.effectBox_textbox)
			}
		}
	}
	
	with (parPlayer) {
		if (object_index == objPlayer or barVisible) {
			var secinsideSprite = healthBarP <= hp/maxHp ? sprBarSetinside_hp : sprBarSetinsideRed_hp
			var eneColor = energy == maxEnergy ? c_white : c_ltgray
	
			/*draw_sprite_general(sprBarSetinside_hp, -1, 0, 0, 135, 12, sx-135/2, sy-100, 1, 1, 0, c_black, c_black, c_black, c_black, 0.15)
			draw_sprite_general(sprBarSetinside_mana, -1, 0, 0, 134, 13, sx-67, sy-88, 1, 1, 0, c_black, c_black, c_black, c_black, 0.15)*/
		
			draw_sprite_general(secinsideSprite, -1, 0, 0, 135*healthBarP, 12, sx-135/2, sy-100, 1, 1, 0, c_white, c_white, c_white, c_white, 0.35)
			draw_sprite_general(sprBarSetinside_mana, -1, 0, 0, 135*manaBarP, 13, sx-67, sy-88, 1, 1, 0, c_white, c_white, c_white, c_white, 0.35)

			if (healthBarP < 1)
				draw_sprite_general(sprBarSetinsideRed_hp, -1, 135*healthBarP, 0, 2, 12, sx-135/2+135*healthBarP, sy-100, 1, 1, 0, c_black, c_black, c_black, c_black, 1)
	
			if (manaBarP < 1)
				draw_sprite_general(sprBarSetinside_mana, -1, 135*manaBarP, 0, 2, 13, sx-67+134*manaBarP, sy-88, 1, 1, 0, c_black, c_black, c_black, c_black, 1)
	
			if (energyBarP < 0.98)
				draw_sprite_general(sprBarSetinside_energy, -1, 130*energy/maxEnergy, 0, 2, 37, sx-65+130*energy/maxEnergy, sy-104, 1, 1, 0, c_black, c_black, c_black, c_black, 1)
	
			draw_sprite_general(sprBarSetinside_hp, -1, 0, 0, 135*hp/maxHp, 12, sx-135/2, sy-100, 1, 1, 0, c_white, c_white, c_white, c_white, 0.5)
			draw_sprite_general(sprBarSetinside_mana, -1, 0, 0, 135*mana/maxMana, 13, sx-67, sy-88, 1, 1, 0, c_white, c_white, c_white, c_white, 0.5)
			draw_sprite_general(sprBarSetinside_energy, -1, 0, 0, 130*energy/maxEnergy, 37, sx-65, sy-104, 1, 1, 0, eneColor, eneColor, eneColor, eneColor, 0.5)
			draw_sprite_ext(sprBarSet, -1, sx, sy-88, 1, 1, 0, c_white, 1)
	
			draw_set_halign(fa_center) draw_set_valign(fa_center) draw_set_font(fontBarText)
				draw_text(sx, sy-95, string(ceil(hp)))
				draw_text(sx, sy-83, string(ceil(mana)))
		
			draw_set_font(fontName) draw_set_color(c_white)
				draw_text_outlined(sx, sy-115, name, 2, c_black, 10, 1, 1, 0)
			draw_set_default()
		}
	}
	
	with (parNPC) {
		if (barVisible) {
			var size = 1
		
			draw_sprite_general(sprBar2inside_hp, -1, 0, 0, 110, 9, sx-55, sy-60, size, size, 0, c_black, c_black, c_black, c_black, 0.15)
			draw_sprite_general(sprBar2insideRed_hp, -1, 0, 0, 110*healthBarP, 9, sx-55, sy-60, size, size, 0, c_white, c_white, c_white, c_white, 0.35)
			
			if (healthBarP != 1)
				draw_sprite_general(sprBarSetinside_hp, -1, 110*healthBarP, 0, 2, 9, sx-55+110*healthBarP*size, sy-60, size, size, 0, c_black, c_black, c_black, c_black, 1)
	
			draw_sprite_general(sprBar2inside_hp, -1, 0, 0, 110*hp/maxHp, 9, sx-55, sy-60, size, size, 0, c_white, c_white, c_white, c_white, 0.5)
			draw_sprite_ext(sprBar, -1, sx, sy-56, size, size, 0, c_white, 1)
				
			draw_set_halign(fa_center) draw_set_valign(fa_center) draw_set_font(fontBarText)
				draw_text(sx, sy-56, string(ceil(hp)))
			
			if (name != undefined) {
				draw_set_font(fontName) draw_set_color(c_ltgray)
					draw_text_outlined(sx, sy-75, name, 2, c_black, 10, 0.88, 0.88, 0)
				draw_set_default()
			}
			
			if (hover)
				draw_sprite_ext(sprMarkBubble, -1, sx, sy, 0.95, 0.95, 0, c_white, 1)
		}
	}

	mouseOnSkillBox = undefined
	for (var i = 0; i < 5; i++) {
		var skill = objPlayer.skills[i]
		
		var xx = -69+guiWidth/2-50+i*59
		var yy = -47+guiHeight
		
		if (mouseOnSkillBox == undefined and point_distance(global.dmx, global.dmy, xx, yy) < 30)
			mouseOnSkillBox = i
		
		if (skill.index != undefined and global.held_box != skill) {			
			if (objPlayer.mana < skill.mana)
				draw_sprite_ext(sprSkillColor, 2, xx, yy, 1, 1, 0, c_white, 1)
			else if (objPlayer.energy < skill.energy)
				draw_sprite_ext(sprSkillColor, 3, xx, yy, 1, 1, 0, c_white, 1)
			else
				draw_sprite_ext(sprSkillColor, skill.cooldown == 0, xx, yy, 1, 1, 0, c_white, 1)
		
			draw_sprite(skill.sprite, -1, xx, yy)
		
			if (objPlayer.stunned)
				draw_sprite_ext(sprSkillColor, 4, xx, yy, 1, 1, 0, c_black, 0.7)
		
			var rate = skill.cooldown/skill.cooldownmax
			
			if (rate > 0.03) {
				draw_set_alpha(0.65)
					draw_rectangle(xx-23, yy-23,
								   xx+23, yy-23+46*rate, 0)
				draw_set_alpha(1)
			
				draw_rectangle(xx-23, yy-23+46*rate-2,
								xx+23, yy-23+46*rate, 0)
			}
		}
		
		if (mouseOnSkillBox != i) {
			draw_set_alpha(0.2)
				draw_rectangle(xx-23, yy-23, xx+23, yy+23, 0)
			draw_set_alpha(1)
		}
	}
		
	draw_sprite(sprBorderSkills, -1, guiWidth/2, guiHeight)
	
	for (var i = 0; i < 5; i++) {
		var xx = -69+guiWidth/2-50+i*59
		var yy = -7+guiHeight
	
		draw_set_alpha(0.5)
			//draw_roundrect(xx-24, yy-5, xx+24, yy+3, 0)
	
			draw_set_color(c_white) draw_set_center() draw_set_font(fontGUi_small) draw_set_alpha(0.9)
				if (i < 2)
					draw_text_outlined(xx, yy, string(i+1), 3, c_black, 12, 1.05, 1.05, 0)
				else if (i == 2)
					draw_text_outlined(xx, yy, "Space", 3, c_black, 12, 1.05, 1.05, 0)
				else if (i == 3)
					draw_text_outlined(xx, yy, "Shift", 3, c_black, 12, 1.05, 1.05, 0)
				else if (i == 4)
					draw_text_outlined(xx, yy, "Ctrl", 3, c_black, 12, 1.05, 1.05, 0)
			draw_set_color(c_black)
		draw_set_alpha(1) draw_set_default()
	}
}
else
	draw_rectangle(-1, -1, guiWidth+1, guiHeight+1, 0)
	
mouseOnMLogo = false
mouseOnSLogo = false
mouseOnCLogo = false
mouseOnBLogo = false
mouseOnQLogo = false

if (point_distance(global.dmx, global.dmy, 35, guiHeight-35) < 35)
	mouseOnMLogo = true
	
var logo_skills_x = guiWidth/2+270
var logo_character_x = guiWidth/2+200
var logo_inventory_x = guiWidth/2-270
var logo_quest_x = guiWidth/2-200
var logo_height = guiHeight-28
if (global.dmy > guiHeight-53) {
	if (global.dmx > logo_skills_x-22 and global.dmx < logo_skills_x+22)
		mouseOnSLogo = true
	else if (global.dmx > logo_character_x-22 and global.dmx < logo_character_x+22)
		mouseOnCLogo = true
	else if (global.dmx > logo_inventory_x-22 and global.dmx < logo_inventory_x+22)
		mouseOnBLogo = true
	else if (global.dmx > logo_quest_x-22 and global.dmx < logo_quest_x+22)
		mouseOnQLogo = true
}
	
draw_sprite_ext(sprSkillTableBelow, -1, guiWidth/2, guiHeight, 1, 1, 0, c_white, 1)

draw_sprite_ext(sprMapLogo, -1, 35, guiHeight-35, 1, 1, 0, mouseOnMLogo ? c_white : c_ltgray, 1)

draw_sprite_ext(sprWindowLogoBack, mouseOnSLogo, logo_skills_x, logo_height, 1, 1, 0, c_white, 1)
draw_sprite_ext(sprSkillsLogo, -1, logo_skills_x, logo_height, 1, 1, 0, c_white, 1)

draw_sprite_ext(sprWindowLogoBack, mouseOnCLogo, logo_character_x, logo_height, 1, 1, 0, c_white, 1)
draw_sprite_ext(sprCharinfoLogo, -1, logo_character_x, logo_height, 1, 1, 0, c_white, 1)

draw_sprite_ext(sprWindowLogoBack, mouseOnBLogo, logo_inventory_x, logo_height, 1, 1, 0, c_white, 1)
draw_sprite_ext(sprinventoryLogo, -1, logo_inventory_x, logo_height, 1, 1, 0, c_white, 1)

draw_sprite_ext(sprWindowLogoBack, mouseOnQLogo, logo_quest_x, logo_height, 1, 1, 0, c_white, 1)
draw_sprite_ext(sprQuestLogo, -1, logo_quest_x, logo_height, 1, 1, 0, c_white, 1)

draw_sprite(sprChat, global.chatActive, display_get_gui_width()-405, display_get_gui_height()-170)
draw_set_valign(fa_center)
var ds_size = ds_list_size(global.chatHistory)
for (var i = 0; i < ds_size; i++) {
	var chat_message = global.chatHistory[| i]
	draw_set_color(chat_message.color)
		draw_set_font(fontGUi_small_b)
			draw_text_outlined(display_get_gui_width()-405+10, display_get_gui_height()-166+10+i*13.5, chat_message.title, 1, c_black, 10, 0.85, 0.85, 0)
		draw_set_font(fontGUi_small)
			draw_text_outlined(display_get_gui_width()-405+10+64, display_get_gui_height()-166+10+i*13.5, "●", 1, c_black, 10, 0.85, 0.85, 0)
	draw_set_color(c_white)
	draw_text_outlined(display_get_gui_width()-405+10+74, display_get_gui_height()-166+10+i*13.5, chat_message.txt, 1, c_black, 10, 0.85, 0.85, 0)
}

if (global.chatActive) {
	draw_set_color(c_white) draw_set_font(fontGUi_small)
			draw_set_color(c_ltyellow)
				draw_set_font(fontGUi_small_b)
					draw_text_outlined(display_get_gui_width()-405+14, display_get_gui_height()-166+139, global.clientName, 1, c_black, 10, 0.85, 0.85, 0)
				draw_set_font(fontGUi_small)
					draw_text_outlined(display_get_gui_width()-405+74, display_get_gui_height()-166+139, "●", 1, c_black, 10, 0.85, 0.85, 0)
			draw_set_color(c_white)
			draw_text_outlined(display_get_gui_width()-405+16+74, display_get_gui_height()-166+139, keyboard_string, 1, c_black, 10, 0.85, 0.85, 0)
			
			if (isChatSelVisible)
				draw_text_outlined(display_get_gui_width()-405+16+string_width(keyboard_string)*0.85+74-3, display_get_gui_height()-166+139, "|", 1, c_black, 10, 0.85, 0.85, 0)
}
draw_set_font(fontMain) draw_set_valign(fa_top)
	
draw_set_color(c_white) draw_set_alpha(0.5) 
	draw_text_transformed(76, display_get_gui_height()-28, "FPS: "+string(fps)+"/"+string(room_speed), 0.7, 0.7, 0)
	if (global.ping_check_mode)
		draw_text_transformed(76, display_get_gui_height()-68, "Ping: "+string(global.ping), 0.7, 0.7, 0)
	draw_text_transformed(76, display_get_gui_height()-48, "Received Errors: "+string(global.networkErrors_count), 0.7, 0.7, 0)
draw_set_alpha(1) draw_set_default()