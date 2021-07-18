if (active) {
/*if (hold)
	animTarget = round(target+5*holdDir)
else */if (animTarget != undefined) {
		var minDiff = angle_difference(target, animTarget)
		if (abs(minDiff) > animSpeed*delta())
			joint_rotate_fixed(target-animSpeed*sign(minDiff)*delta())
		else {   
			joint_rotate_fixed(animTarget)
			animTarget = undefined
		}
	}

}