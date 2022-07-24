function get_skill_COMMON(_index, _upgrade) {
	switch (_index) {
		case SKILL_0:
			return { name: "Explosion", index: _index, sprite: get_skill_sprite(_index), upgrade: _upgrade }
		case SKILL_1:
			return { name: "Arrow", index: _index, sprite: get_skill_sprite(_index), upgrade: _upgrade }
		case SKILL_2:
			return { name: "Laser", index: _index, sprite: get_skill_sprite(_index), upgrade: _upgrade }
		case SKILL_3:
			return { name: "Speed", index: _index, sprite: get_skill_sprite(_index), upgrade: _upgrade }
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
			return "[b]"+skill.name+" (+"+string(skill.upgrade)+")[/b]\nDeals [c="+string(c_fuchsia)+"]"+string(round((100+10*skill.upgrade)/100*10*100))+"% Magical[/c]\nCost: [c="+string(c_ltblue)+"]"+string(global.skill_mana_COMMON[skill.index])+" Mana[/c]\n[img="+sprite_get_name(sprClock)+"]"+string(global.skill_cooldown_max_COMMON[skill.index])
		case SKILL_1:
			return "[b]"+skill.name+" (+"+string(skill.upgrade)+")[/b]"+string(global.skill_cooldown_max_COMMON[skill.index])+" secs"
		case SKILL_2:
			return "[b]"+skill.name+" (+"+string(skill.upgrade)+")[/b]\nDeals [c="+string(c_fuchsia)+"]"+string(round(1/6*(100+10*skill.upgrade)/100*10*100))+"% Magical[/c]/sec\n\n[c="+string(c_grey)+"]Can be reflected[/c]\nCost: [c="+string(c_ltblue)+"]"+string(global.skill_mana_COMMON[skill.index]/global.skill_cooldown_max_COMMON[skill.index])+" Mana[/c]/sec"
		case SKILL_3:
			return "[b]"+skill.name+" (+"+string(skill.upgrade)+")[/b]\n[c="+string(c_grey)+"]Be faster for "+string(global.skill_casttime_max_COMMON[SKILL_3])+" secs[/c]\nCost: [c="+string(c_teal)+"]"+string(global.skill_energy_COMMON[skill.index])+" Energy[/c]\n[img="+sprite_get_name(sprClock)+"]"+string(global.skill_cooldown_max_COMMON[skill.index])
	}
}

function Skills_COMMON() {
	#macro SKILL_COUNT 4
	#macro SKILL_0 0
	#macro SKILL_1 1
	#macro SKILL_2 2
	#macro SKILL_3 3
}