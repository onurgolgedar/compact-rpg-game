function anim_set_stance(stance, time) {
	if (owner != undefined and instance_exists(owner))
		owner.rigidbody_set_definedstance(stance, time*1.03+0.008)
}

function time_delayed(time) {
	return time*1.07+0.01
}