event_inherited()
skill_index = SKILL_2
laser_index = 0

function execute() {
	if (instance_exists(owner))
		with (parTarget_SERVER) {
			if (id != other.owner) {
				if (place_meeting(x, y, other.id)) {
					net_server_send(SOCKET_ID_ALL, CODE_EFFECT_LASER, targetID, BUFFER_TYPE_INT16, true)
				
					change_hp(-other.owner.magicalPower/6)
				
					var pow = 500
					var dir = other.image_angle
					ds_map_add(spds, irandom(999999), {xx: lengthdir_x(pow, dir), yy: lengthdir_y(pow, dir)})
				}
			}
		}
	
	instance_destroy()
}

function_call_COMMON(execute, 0.1, true)