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