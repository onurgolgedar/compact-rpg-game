image_angle_target = point_direction(x, y, mouse_x, mouse_y)
event_inherited()

// Skills Prediction
for (var i = 0; i < 5; i++) {
	var skill = skills[i]
	
	if (skill.index != undefined) {
		var value = global.delta_COMMON*(1+0.2*(class == CLASS_ASSASSIN))
		if (skill.cooldown-value > 0)
			skill.cooldown -= value
		else
			skill.cooldown = 0
	}
}

audio_listener_position(x, y, 0)