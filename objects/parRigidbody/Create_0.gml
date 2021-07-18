#region FUNCTION DECLARATIONS
function rigidbody_destroy() {
	if (rigidbodyParts != undefined) {
		var ds_size = ds_list_size(rigidbodyParts)
		for (var i = 0; i < ds_size; i++)
			instance_destroy(ds_list_find_value(rigidbodyParts, i))
	
		rigidbody_list_destroy()
	}
}
function rigidbody_list_destroy() {
	if (rigidbodyParts != undefined) {
		if (ds_exists(rigidbodyParts, ds_type_list))
			ds_list_destroy(rigidbodyParts)
		
		rigidbodyParts = undefined
	}
}
function stop_animations() {
	with (parAnimation) {
		if (owner == other.id) {
			event_perform(ev_other, ev_user5)
		
			instance_destroy()
		}
	}
}
function rigidbody_noarms() {
	if (rigidbodyParts != undefined) {
		alarm[0] = 1
		alarm[1] = -1
	
		if (leftArm[0] != undefined) {
			with (leftArm[0]) {
				image_xscale = -0.8
				image_yscale = 1.65
			}
		}
		if (leftArm[1] != undefined)
			with (leftArm[1])
				image_yscale = 0
		if (rightArm[0] != undefined) {
			with (rightArm[0]) {
				image_xscale = -0.8
				image_yscale = -1.65
			}
		}
		if (rightArm[1] != undefined)
			with (rightArm[1])
				image_yscale = 0
		if (leftHand != undefined)
			with (leftHand)
				image_yscale = 0
		if (rightHand != undefined)
			with (rightHand)
				image_yscale = 0
			
		noArms = true
	}
}
function rigidbody_set_definedstance(stance, duration) {
	if (id.stance != stance) {
		duration = duration == undefined ? 0.25 : duration
		id.stance = stance
		
		if (id.stance != STANCE_POSE and noArms) {		
			#region Reset Scales		
			if (leftArm[0] != undefined) {
				with (leftArm[0]) {
					image_xscale = 1
					image_yscale = 1
				}
			}
			if (leftArm[1] != undefined) {
				with (leftArm[1]) {
					image_xscale = 1
					image_yscale = 1
				}
			}
			if (rightArm[0] != undefined) {
				with (rightArm[0]) {
					image_xscale = 1
					image_yscale = -1
				}
			}
			if (rightArm[1] != undefined) {
				with (rightArm[1]) {
					image_xscale = 1
					image_yscale = -1
				}
			}
			if (shoulders != undefined) {
				with (shoulders) {
					image_xscale = 1
					image_yscale = 1
				}
			}
			if (leftHand != undefined) {
				with (leftHand) {
					image_xscale = 1
					image_yscale = 1
				}
			}
			if (rightHand != undefined) {
				with (rightHand) {
					image_xscale = 1
					image_yscale = -1
				}
			}
			#endregion
		
			alarm[0] = -1
			alarm[1] = 1
		}
		
		if (stance == STANCE_NORMAL)
			rigidbody_set_stance(
				22, duration,
				40, duration,
				-77, duration,
				-17, duration,
				89, duration,
				-108, duration,
				-10, duration, 1)
		else if (stance == STANCE_OPEN)
			rigidbody_set_stance(
				6, duration,
				85, duration,
				-21, duration,
				-3, duration,
				89, duration,
				-25, duration,
				-9, duration, 2)
		else if (stance == STANCE_POSE)
			rigidbody_set_stance(
				6, duration,
				85, duration,
				-21, duration,
				-3, duration,
				89, duration,
				-25, duration,
				-9, duration, 2)
		else if (argument[0] == STANCE_BASE_CALM_SWORD)
			rigidbody_set_stance(
				21, duration,
				40, duration,
				-71, duration,
				-3, duration,
				64, duration,
				-100, duration,
				-9, duration, 2)
		else if (argument[0] == STANCE_BASE_SWORD)
			rigidbody_set_stance(
				-42, duration,
				75, duration,
				-92, duration,
				-31, duration,
				59, duration,
				-77, duration,
				30, duration, 2)
		else if (argument[0] == STANCE_BA0_SWORD_001)
			rigidbody_set_stance(
				-70, duration,
				64.5, duration,
				-109, duration,
				-21.4, duration,
				87, duration,
				-103, duration,
				22.2, duration)
		else if (argument[0] == STANCE_BA0_SWORD_002)
			rigidbody_set_stance(
				-57, duration,
				99, duration,	
				-97, duration,
				-22, duration,
				79, duration,
				-117, duration,
				-14, duration)
		else if (argument[0] == STANCE_BA0_SWORD_003)
			rigidbody_set_stance(
				-27, duration,
				124, duration,	
				-122, duration,
				-27, duration,
				79, duration,
				-87, duration,
				-36, duration)
		else if (argument[0] == STANCE_BA1_SWORD_001)
			rigidbody_set_stance(
				-20, duration,
				20.5, duration,
				-87, duration,
				-21.4, duration,
				18, duration,
				-52, duration,	
				41.6, duration)
		else if (argument[0] == STANCE_BA1_SWORD_002)
			rigidbody_set_stance(
				-27, duration,
				54, duration,
				-114, duration,
				-22, duration,
				9, duration,
				-42, duration,
				49, duration)
		else if (argument[0] == STANCE_BA1_SWORD_003)
			rigidbody_set_stance(
				18, duration,
				49, duration,
				-92, duration,
				-27, duration,
				59, duration,
				-27, duration,
				14, duration)
	}
}

/// @function rigidbody_set_stance(sh, shTime, al, alTime, fal, falTime, hl, hlTime, ar, arTime, far, farTime, hr, hrTime)
function rigidbody_set_stance(sh, shTime, al, alTime, fal, falTime, hl, hlTime, ar, arTime, far, farTime, hr, hrTime) {
	if (rigidbodyParts != undefined) {
		if (leftHand != undefined)
			with (leftHand)
			    joint_animate(hl, max(hlTime, 0.0001), 0)
		
		if (rightHand != undefined)
			with (rightHand)
			    joint_animate(hr, max(hrTime, 0.0001), 0)
				
		if (leftArm[0] != undefined)
			with (leftArm[0])
			    joint_animate(al, max(alTime, 0.0001))
				
		if (rightArm[0] != undefined)
			with (rightArm[0])
			    joint_animate(ar, max(arTime, 0.0001))
				
		if (leftArm[1] != undefined)
			with (leftArm[1])
			    joint_animate(fal, max(falTime, 0.0001))
    
		if (rightArm[1] != undefined)
			with (rightArm[1])
			    joint_animate(far, max(farTime, 0.0001))
		
		if (shoulders != undefined)
			with (shoulders)
			    joint_animate(sh, max(shTime, 0.0001))
	}
}
function rigidbody_create() {
	shoulders = instance_create(x, y, objJoint)
	shoulders.sprite_index = argument[0]
	shoulders.depth = depth+2
	shoulders.image_angle = image_angle
	shoulders.root = id
	shoulders.image_blend = image_blend
	shoulders.name = "Shoulders"
	shoulders.joint_initiate(id, shoulders.x, shoulders.y, 1)

	leftArm[0] = instance_create(x+lengthdir_x(argument[2], 90-image_angle), y+lengthdir_y(argument[2], 90-image_angle), objJoint)
	leftArm[0].sprite_index = argument[1]
	leftArm[0].depth = depth+3
	leftArm[0].image_angle = image_angle
	leftArm[0].root = id
	leftArm[0].image_blend = image_blend
	leftArm[0].name = "Left Arm"
	leftArm[0].joint_initiate(shoulders, leftArm[0].x, leftArm[0].y, 1)

	rightArm[0] = instance_create(x+lengthdir_x(argument[2], 270-image_angle), y+lengthdir_y(argument[2], 270-image_angle), objJoint)
	rightArm[0].sprite_index = argument[1]
	rightArm[0].depth = depth+3
	rightArm[0].image_angle = image_angle
	rightArm[0].root = id
	rightArm[0].image_blend = image_blend
	rightArm[0].name = "Right Arm"
	rightArm[0].joint_initiate(shoulders, rightArm[0].x, rightArm[0].y, -1)

	leftArm[1] = instance_create(leftArm[0].x+lengthdir_x(argument[4], 0-image_angle), leftArm[0].y+lengthdir_y(argument[4], 0-image_angle), objJoint)
	leftArm[1].sprite_index = argument[3]
	leftArm[1].depth = depth+4
	leftArm[1].image_angle = image_angle
	leftArm[1].root = id
	leftArm[1].image_blend = image_blend
	leftArm[1].name = "Left Front Arm"
	leftArm[1].joint_initiate(leftArm[0], leftArm[1].x, leftArm[1].y, 1)

	rightArm[1] = instance_create(rightArm[0].x+lengthdir_x(argument[4], 0-image_angle), rightArm[0].y+lengthdir_y(argument[4], 0-image_angle), objJoint)
	rightArm[1].sprite_index = argument[3]
	rightArm[1].depth = depth+4
	rightArm[1].image_angle = image_angle
	rightArm[1].root = id
	rightArm[1].image_blend = image_blend
	rightArm[1].name = "Right Front Arm"
	rightArm[1].joint_initiate(rightArm[0], rightArm[1].x, rightArm[1].y, -1)

	leftHand = instance_create(leftArm[1].x+lengthdir_x(argument[6], 0-image_angle), leftArm[1].y+lengthdir_y(argument[6], 0-image_angle), objJoint)
	leftHand.sprite_index = argument[5]
	leftHand.depth = depth-1
	leftHand.image_angle = image_angle
	leftHand.root = id
	leftHand.image_blend = image_blend
	leftHand.name = "Left Hand"
	leftHand.joint_initiate(leftArm[1], leftHand.x, leftHand.y, 1)

	rightHand = instance_create(rightArm[1].x+lengthdir_x(argument[6], 0-image_angle), rightArm[1].y+lengthdir_y(argument[6], 0-image_angle), objJoint)
	rightHand.sprite_index = argument[5]
	rightHand.depth = depth-1
	rightHand.image_angle = image_angle
	rightHand.root = id
	rightHand.image_blend = image_blend
	rightHand.name = "Right Hand"
	rightHand.joint_initiate(rightArm[1], rightHand.x, rightHand.y, -1)

	rightArm[0].image_yscale = -1
	rightArm[1].image_yscale = -1
	rightHand.image_yscale = -1

	rigidbodyParts = ds_list_create()
	rigidbodyType = 1

	ds_list_add(rigidbodyParts, rightArm[1])
	ds_list_add(rigidbodyParts, rightArm[0])
	ds_list_add(rigidbodyParts, leftArm[1])
	ds_list_add(rigidbodyParts, leftArm[0])
	ds_list_add(rigidbodyParts, leftHand)
	ds_list_add(rigidbodyParts, rightHand)
	ds_list_add(rigidbodyParts, shoulders)
}
function joint_turn_with_velocity(angle, velocity) {
	var turn_ad = angle_difference(image_angle, angle)
	
	if (abs(turn_ad) > 1) {
		var value = -velocity*sign(turn_ad)*clamp(power(abs(turn_ad)/180, 0.85), 0.1, 2)*global.delta_COMMON
		if (abs(turn_ad) >= abs(value)+1)
		   image_angular_velocity = value
		else {
			image_angle = angle
			image_angular_velocity = 0
		}
	}
}
#endregion

animationController = undefined
	
rigidbodyParts = undefined
rigidbodyType = -1

stance = undefined
noArms = false

image_angular_velocity = 0