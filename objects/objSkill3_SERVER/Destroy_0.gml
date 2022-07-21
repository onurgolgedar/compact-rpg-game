event_inherited()

if (alarm[0] == -1)
	with (owner) {
		movementSpeed_add -= 350*(100+40*other.skill.upgrade)/100
		movementSpeed = movementSpeed_base+movementSpeed_add
	}