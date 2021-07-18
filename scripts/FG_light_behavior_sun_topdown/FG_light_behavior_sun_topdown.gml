function FG_light_behavior_sun_topdown() {
	isDirectional = true
	strong = (1 - sqr(max(0, -lengthdir_y(1, zDirection))))*0.95
	Color =  merge_color(c_orange, c_black, 0.7 + strong*0.3)


}
