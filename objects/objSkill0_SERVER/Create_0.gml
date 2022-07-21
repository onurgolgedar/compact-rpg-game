event_inherited()
skill_index = SKILL_0

function execute() {
	if (instance_exists(owner)) {
		var casttime = skill.casttime
		var casttime_max = skill.casttimemax
		x = owner.x
		y = owner.y
		image_xscale = 0.5+2.5*casttime/casttime_max
		image_yscale = 0.5+2.5*casttime/casttime_max
	}
	
	with (parTarget_SERVER) {
		if (id != other.owner) {
			if (place_meeting(x, y, other.id)) {
				change_hp(-other.owner.magicalPower*(100+10*other.skill.upgrade)/100)
			
				var pow = 1200+clamp(1200-point_distance(x, y, other.x, other.y)/5*30, 0, 1200)
				var dir = point_direction(other.x, other.y, x, y)
				ds_map_add(spds, irandom(999999), {xx: lengthdir_x(pow, dir), yy: lengthdir_y(pow, dir)})
			}
		}
	}

	instance_destroy()
}