x += spd.xx*global.delta_COMMON
y += spd.yy*global.delta_COMMON

if (disappearing == 0)
	image_alpha += 1/(SEC/3)
else {
	var value = 1/(SEC/6)*disappearing
	if (image_alpha-value > 0)
		image_alpha -= value
	else
		instance_destroy()
}