function FG_light_behavior_sun_platformer() {
	isDirectional = true
	zDirection = 90
	strong = sqrt(max(0, -lengthdir_y(1, image_angle+90)))*0.95
	Color =  merge_color(c_orange, c_black, 0.7 + strong*0.3)


}
