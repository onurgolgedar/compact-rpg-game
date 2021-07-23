if (is_alive()) {
	with (parPlayer) {
		if (object_index == objPlayer or barVisible) {
			var secInsideSprite = healthBarP <= hp/maxHp ? sprBarSetInside_hp : sprBarSetInsideRed_hp
			var eneColor = energy == maxEnergy ? c_white : c_ltgray
	
			/*draw_sprite_general(sprBarSetInside_hp, -1, 0, 0, 135, 12, sx-135/2, sy-100, 1, 1, 0, c_black, c_black, c_black, c_black, 0.15)
			draw_sprite_general(sprBarSetInside_mana, -1, 0, 0, 134, 13, sx-67, sy-88, 1, 1, 0, c_black, c_black, c_black, c_black, 0.15)*/
		
			draw_sprite_general(secInsideSprite, -1, 0, 0, 135*healthBarP, 12, sx-135/2, sy-100, 1, 1, 0, c_white, c_white, c_white, c_white, 0.35)
			draw_sprite_general(sprBarSetInside_mana, -1, 0, 0, 135*manaBarP, 13, sx-67, sy-88, 1, 1, 0, c_white, c_white, c_white, c_white, 0.35)

			if (healthBarP < 1)
				draw_sprite_general(sprBarSetInsideRed_hp, -1, 135*healthBarP, 0, 2, 12, sx-135/2+135*healthBarP, sy-100, 1, 1, 0, c_black, c_black, c_black, c_black, 1)
	
			if (manaBarP < 1)
				draw_sprite_general(sprBarSetInside_mana, -1, 135*manaBarP, 0, 2, 13, sx-67+134*manaBarP, sy-88, 1, 1, 0, c_black, c_black, c_black, c_black, 1)
	
			if (energyBarP < 0.98)
				draw_sprite_general(sprBarSetInside_energy, -1, 130*energy/maxEnergy, 0, 2, 37, sx-65+130*energy/maxEnergy, sy-104, 1, 1, 0, c_black, c_black, c_black, c_black, 1)
	
			draw_sprite_general(sprBarSetInside_hp, -1, 0, 0, 135*hp/maxHp, 12, sx-135/2, sy-100, 1, 1, 0, c_white, c_white, c_white, c_white, 0.5)
			draw_sprite_general(sprBarSetInside_mana, -1, 0, 0, 135*mana/maxMana, 13, sx-67, sy-88, 1, 1, 0, c_white, c_white, c_white, c_white, 0.5)
			draw_sprite_general(sprBarSetInside_energy, -1, 0, 0, 130*energy/maxEnergy, 37, sx-65, sy-104, 1, 1, 0, eneColor, eneColor, eneColor, eneColor, 0.5)
			draw_sprite_ext(sprBarSet, -1, sx, sy-88, 1, 1, 0, c_white, 1)
	
			draw_set_halign(fa_center) draw_set_valign(fa_center) draw_set_font(fontBarText)
				draw_text(sx, sy-95, string(ceil(hp)))
				draw_text(sx, sy-83, string(ceil(mana)))
		
			draw_set_font(fontName) draw_set_color(c_white)
				draw_text_outlined(sx, sy-115, name, 2, c_black, 10, 1, 1, 0)
			draw_set_color(c_navy)
				draw_text_outlined(sx, sy-135, class, 2, c_black, 10, 0.8, 0.8, 0)
			draw_set_default()
		}
	}
	
	with (parCreature) {
		if (barVisible) {
			var size = 1
		
			draw_sprite_general(sprBar2Inside_hp, -1, 0, 0, 110, 9, sx-55, sy-60, size, size, 0, c_black, c_black, c_black, c_black, 0.15)
			draw_sprite_general(sprBar2InsideRed_hp, -1, 0, 0, 110*healthBarP, 9, sx-55, sy-60, size, size, 0, c_white, c_white, c_white, c_white, 0.35)
			
			if (healthBarP != 1)
				draw_sprite_general(sprBarSetInside_hp, -1, 110*healthBarP, 0, 2, 9, sx-55+110*healthBarP*size, sy-60, size, size, 0, c_black, c_black, c_black, c_black, 1)
	
			draw_sprite_general(sprBar2Inside_hp, -1, 0, 0, 110*hp/maxHp, 9, sx-55, sy-60, size, size, 0, c_white, c_white, c_white, c_white, 0.5)
			draw_sprite_ext(sprBar, -1, sx, sy-56, size, size, 0, c_white, 1)
				
			draw_set_halign(fa_center) draw_set_valign(fa_center) draw_set_font(fontBarText)
				draw_text(sx, sy-56, string(ceil(hp)))
			draw_set_default()
		}
	}

	mouseOnSkillBox = undefined
	for (var i = 0; i < 5; i++) {
		var skill = objPlayer.skills[i]
		
		var xx = -69+guiWidth/2-50+i*59
		var yy = -47+guiHeight
		
		if (mouseOnSkillBox == undefined and point_distance(global.dmx, global.dmy, xx, yy) < 30)
			mouseOnSkillBox = i
		
		if (skill.index != undefined) {			
			if (objPlayer.mana < skill.mana)
				draw_sprite_ext(sprSkillColor, 2, xx, yy, 1, 1, 0, c_white, 1)
			else if (objPlayer.energy < skill.energy)
				draw_sprite_ext(sprSkillColor, 3, xx, yy, 1, 1, 0, c_white, 1)
			else
				draw_sprite_ext(sprSkillColor, skill.cooldown == 0, xx, yy, 1, 1, 0, c_white, 1)
		
			draw_sprite(global.skill_sprite[skill.index], -1, xx, yy)
		
			if (objPlayer.stunned)
				draw_sprite_ext(sprSkillColor, 4, xx, yy, 1, 1, 0, c_black, 0.7)
		
			var rate = skill.cooldown/skill.maxcooldown
			
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
draw_sprite_ext(sprCharInfoLogo, -1, logo_character_x, logo_height, 1, 1, 0, c_white, 1)

draw_sprite_ext(sprWindowLogoBack, mouseOnBLogo, logo_inventory_x, logo_height, 1, 1, 0, c_white, 1)
draw_sprite_ext(sprInventoryLogo, -1, logo_inventory_x, logo_height, 1, 1, 0, c_white, 1)

draw_sprite_ext(sprWindowLogoBack, mouseOnQLogo, logo_quest_x, logo_height, 1, 1, 0, c_white, 1)
draw_sprite_ext(sprQuestLogo, -1, logo_quest_x, logo_height, 1, 1, 0, c_white, 1)
	
draw_set_alpha(0.5) draw_set_color(c_white)
	draw_text_transformed(76, display_get_gui_height()-28, "FPS: "+string(fps)+"/"+string(room_speed), 0.7, 0.7, 0)
	draw_text_transformed(76, display_get_gui_height()-48, "Ping: "+string(global.ping_udp), 0.7, 0.7, 0)
	draw_text_transformed(76, display_get_gui_height()-68, "Receive Errors: "+string(global.networkErrors_count), 0.7, 0.7, 0)
draw_set_alpha(1) draw_set_color(c_black)

if (instance_exists(objInventory_window)) {
	with (objInventory_window)
		if (global.held_box != undefined) {
			draw_outline_origin(global.held_box.item.sprite, -1, global.dmx, global.dmy, 0.47, 0.47, 60, 1)
			draw_sprite_origin_ext(global.held_box.item.sprite, -1, global.dmx, global.dmy, 0.47, 0.47, 60, c_white, 1)
		}
}