image_angle += image_angular_velocity

var value = 0.5
if (headOffset-value > 0)
    headOffset -= value
else
	headOffset = 0