function cast_skill(skill_index, instance) {
	var success = false
	var skill_object = undefined
	
	with (instance) {
		var skill = undefined
		var ds_size = array_length(skills)
		for (var i = 0; i < ds_size; i++)
			if (skills[i] != undefined and skills[i].index == skill_index) {
				skill = skills[i]
				break
			}
		
		if (skill != undefined) {
			if (skill.casttime == undefined and skill.cooldown == 0 and energy >= skill.energy and mana >= skill.mana) {
				success = true
			
				if (skill.casttimemax != undefined)
					skill.casttime = 0
				
				skill.cooldown = skill.cooldownmax
			
				change_energy(-skill.energy)
				change_mana(-skill.mana)
			
				if (skill.object != undefined) {
					skill_object = instance_create_depth(x, y, 0, skill.object)
					skill_object.owner = instance
					skill_object.skill = skill
				}
			}
		}
	}
		
	return skill.object != undefined ? skill_object : success
}