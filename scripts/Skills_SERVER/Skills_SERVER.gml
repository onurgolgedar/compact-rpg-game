function define_skills_SERVER() {
	global.skill_casttime_max[SKILL_0] = 1
	global.skill_cooldown_max[SKILL_0] = 2
	global.skill_energy[SKILL_0] = 0
	global.skill_mana[SKILL_0] = 20
	global.skill_code[SKILL_0] = _CODE_SKILL0
	global.skill_object[SKILL_0] = objSkill0_SERVER
	
	global.skill_casttime_max[SKILL_1] = undefined
	global.skill_cooldown_max[SKILL_1] = 2
	global.skill_energy[SKILL_1] = 30
	global.skill_mana[SKILL_1] = 0
	global.skill_code[SKILL_1] = _CODE_SKILL1
	global.skill_object[SKILL_1] = objArrow_SERVER
	
	global.skill_casttime_max[SKILL_2] = undefined
	global.skill_cooldown_max[SKILL_2] = 0.04
	global.skill_energy[SKILL_2] = 0
	global.skill_mana[SKILL_2] = 8
	global.skill_code[SKILL_2] = _CODE_SKILL2
	global.skill_object[SKILL_2] = objSkill2_SERVER
	
	global.skill_casttime_max[SKILL_3] = 0.4
	global.skill_cooldown_max[SKILL_3] = 3
	global.skill_energy[SKILL_3] = 60
	global.skill_mana[SKILL_3] = 0
	global.skill_code[SKILL_3] = _CODE_SKILL3
	global.skill_object[SKILL_3] = objSkill3_SERVER
}

function cast_skill(skill_index, instance) {
	var success = false
	var skill_object = undefined
	
	with (instance) {
		var skill = undefined
		var _skills = ds_map_values_to_array(skills)
		var ds_size = array_length(_skills)
		for (var i = 0; i < ds_size; i++)
			if (_skills[i].index == skill_index) {
				skill = _skills[i]
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