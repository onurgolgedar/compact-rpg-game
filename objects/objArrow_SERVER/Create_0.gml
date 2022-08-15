function get_damage() {
	return -30*(100+10*skill.upgrade)/100
}

owner = undefined
skill = undefined
skill_index = SKILL_1

spd = undefined

function_call_COMMON(function() { instance_destroy() }, 1.5, true)

visible = global.drawServer_SERVER