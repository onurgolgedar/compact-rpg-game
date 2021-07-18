function main() {
	function_call(main, 1/20, true)
	
	if (place_meeting(x, y, objPlayer)) {
		if (image_alpha != 0.4) {
			var amount = 0.1
		
			if (image_alpha-amount > 0.4)
				image_alpha -= amount
			else
				image_alpha = 0.4
		}
	}
	else {
		if (image_alpha != 1) {
			var amount = 0.1
		
			if (image_alpha+amount < 1)
				image_alpha += amount
			else
				image_alpha = 1
		}
	}
}

function_call(main, 1/20, true)

if (body_type == 1) {
	var down = instance_create_layer(x, y, "Top", objTreeBody)
	down.image_xscale = random_range(0.9, 1.05)*(1+image_xscale)/2
	down.image_yscale = down.image_xscale
	down.image_angle = image_angle*2
	down.depth += 10
}

var trail = instance_create_layer(x, y, "Floor", objTrail)
trail.image_xscale *= 1.3
trail.image_yscale *= 1.3
trail.image_alpha = 0.7

if (object_index == objTree4) {
	trail.image_blend = c_yellow
	trail.image_xscale *= 1.19
	trail.image_yscale *= 1.19
}

image_speed = 1.2