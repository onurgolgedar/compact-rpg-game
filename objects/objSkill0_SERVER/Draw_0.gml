with (owner) {
	var casttime = other.skill.casttime
	var casttime_max = other.skill.casttimemax
	if (casttime != undefined)
		draw_sprite_ext(other.sprite_index, -1, x, y,
						0.5+2.5*casttime/casttime_max, 0.5+2.5*casttime/casttime_max,
						current_time/3, c_white, 0.3+0.7*casttime/casttime_max)
}