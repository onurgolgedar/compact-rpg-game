function cast_skill_SERVER(skill_index, instance) {
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
					skill_object = instance_create_depth(x, y, 0, asset_get_index(skill.object))
					skill_object.owner = instance
					skill_object.skill = skill
				}
			}
		}
	}
		
	return skill.object != undefined ? skill_object : success
}

function define_skills_base_SERVER() {
	global.skill_object_SERVER[SKILL_0] = object_get_name(objSkill0_SERVER)
	global.skill_object_SERVER[SKILL_1] = object_get_name(objArrow_SERVER)
	global.skill_object_SERVER[SKILL_2] = object_get_name(objSkill2_SERVER)
	global.skill_object_SERVER[SKILL_3] = object_get_name(objSkill3_SERVER)
}