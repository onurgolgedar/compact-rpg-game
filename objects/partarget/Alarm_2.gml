if (xx != y or yy != y) {
	var dis = point_distance(x, y, xx, yy)
	location_dis = lerp(location_dis, dis, 0.4)
	var location_dir = point_direction(x, y, xx, yy)
	if (location_dis < 2 or
		dis > 350) {
		x = xx
		y = yy
	}
	else {
		var value = 1+location_dis/4/room_speed*60
		x += lengthdir_x(value, location_dir)
		y += lengthdir_y(value, location_dir)
	}
}

alarm[2] = 1