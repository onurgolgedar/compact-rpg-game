event_inherited()

if (skill[0] != undefined)
	draw_sprite_ext(sprSkill0, -1, x, y,
					0.5+2.5*skill[0], 0.5+2.5*skill[0],
					current_time/3, c_white, 0.3+0.7*skill[0])