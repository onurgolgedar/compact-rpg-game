function get_skill_COMMON(_index, _upgrade) {
	switch (_index) {
		case SKILL_0:
			return { name: "Skill 0", index: _index, sprite: get_skill_sprite(_index), upgrade: _upgrade }
		case SKILL_1:
			return { name: "Skill 1", index: _index, sprite: get_skill_sprite(_index), upgrade: _upgrade }
		case SKILL_2:
			return { name: "Skill 2", index: _index, sprite: get_skill_sprite(_index), upgrade: _upgrade }
		case SKILL_3:
			return { name: "Skill 3", index: _index, sprite: get_skill_sprite(_index), upgrade: _upgrade }
	}
}

function define_skills_base_COMMON() {
	global.skill_casttime_max_COMMON[SKILL_0] = 1
	global.skill_cooldown_max_COMMON[SKILL_0] = 2
	global.skill_energy_COMMON[SKILL_0] = 0
	global.skill_mana_COMMON[SKILL_0] = 20
	global.skill_code_COMMON[SKILL_0] = _CODE_SKILL0
	global.skill_object_SERVER[SKILL_0] = objSkill0_SERVER // server-side only
	
	global.skill_casttime_max_COMMON[SKILL_1] = undefined
	global.skill_cooldown_max_COMMON[SKILL_1] = 2
	global.skill_energy_COMMON[SKILL_1] = 30
	global.skill_mana_COMMON[SKILL_1] = 0
	global.skill_code_COMMON[SKILL_1] = _CODE_SKILL1
	global.skill_object_SERVER[SKILL_1] = objArrow_SERVER // server-side only
	
	global.skill_casttime_max_COMMON[SKILL_2] = undefined
	global.skill_cooldown_max_COMMON[SKILL_2] = 0.04
	global.skill_energy_COMMON[SKILL_2] = 0
	global.skill_mana_COMMON[SKILL_2] = 8
	global.skill_code_COMMON[SKILL_2] = _CODE_SKILL2
	global.skill_object_SERVER[SKILL_2] = objSkill2_SERVER // server-side only
	
	global.skill_casttime_max_COMMON[SKILL_3] = 0.4
	global.skill_cooldown_max_COMMON[SKILL_3] = 3
	global.skill_energy_COMMON[SKILL_3] = 60
	global.skill_mana_COMMON[SKILL_3] = 0
	global.skill_code_COMMON[SKILL_3] = _CODE_SKILL3
	global.skill_object_SERVER[SKILL_3] = objSkill3_SERVER // server-side only
}

function get_skill_description_COMMON(skill) {
	switch (skill.index) {
		case SKILL_0:
			return "Explosion"
		case SKILL_1:
			return "Shot"
		case SKILL_2:
			return "Laser"
		case SKILL_3:
			return "Speed"
	}
}

function Skills_COMMON() {
	#macro SKILL_COUNT 4
	#macro SKILL_0 0
	#macro SKILL_1 1
	#macro SKILL_2 2
	#macro SKILL_3 3
}