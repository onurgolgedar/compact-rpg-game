event_inherited()

function animation_000() {
	var time = real(id).time*0.3
	
	if (style == 0)
		anim_set_stance(STANCE_BA0_SWORD_001, time/2)
	else if (style == 1)
		anim_set_stance(STANCE_BA0_SWORD_002, time/2)
	else if (style == 2)
		anim_set_stance(STANCE_BA0_SWORD_003, time/2)

	function_call_COMMON(animation_001, time, true)
}

function animation_001() {
	var time = real(id).time*0.3
	
	if (style == 0)
		anim_set_stance(STANCE_BA1_SWORD_001, time/2)
	else if (style == 1)
		anim_set_stance(STANCE_BA1_SWORD_002, time/2)
	else if (style == 2)
		anim_set_stance(STANCE_BA1_SWORD_003, time/2)

	function_call_COMMON(animation_002, time, true)
}

function animation_002() {
	var time = real(id).time*0.4
	
	anim_set_stance(STANCE_NORMAL, time)
	function_call_COMMON(animation_destroy, time_delayed(time), true)
}

function animation_destroy() {
	instance_destroy()
}