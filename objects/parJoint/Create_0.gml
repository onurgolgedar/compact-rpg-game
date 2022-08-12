#region FUNCTION DECLARATIONS
function joint_initiate(owner, x, y, side) {
	real(id).owner = owner
	real(id).side = side
	lock_dis = point_distance(owner.x, owner.y, x, y)
	lock_dir = point_direction(owner.x, owner.y, x, y)
}
function joint_animate(animTarget, animTime) {
	real(id).animTarget = animTarget
	real(id).animSpeed = abs(angle_difference(target, animTarget))/animTime
}
function joint_turn_with_velocity(angle, velocity) {
	var turn_ad = angle_difference(image_angle, angle)
	
	var value = -velocity*sign(turn_ad)*clamp(power(abs(turn_ad)/180, 0.6), 0, 2)*global.delta_COMMON
	if (abs(turn_ad) >= abs(value))
	    image_angular_velocity = value
	else {
		image_angle = angle
		image_angular_velocity = 0
	}
}
function joint_rotate_fixed(angle) {
	target = angle
}
	
function timed_set_name() {
	name = "Arm "+string(side == 1 ? "Right" : "Left")
}
#endregion

function_call_COMMON(timed_set_name, 1, false)

target = 0
animTarget = undefined
animSpeed = 0
owner = undefined
root = undefined
name = undefined
lock_dis = 0
lock_dir = 0
image_angular_velocity = 0
active = true

hold = false
holdDir = -1