event_inherited()

if (alarm[0] == -1)
	with (owner) {
		movementSpeed_add -= 380*(100+10*other.skill.upgrade)/100
		movementSpeed = movementSpeed_base+movementSpeed_add
	}