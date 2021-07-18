if ((spd_res.xx == 0 and spd_res.yy == 0)
	or abs(angle_difference(point_direction(0, 0, spd_res.xx, spd_res.yy), point_direction(0, 0, other.dir.xx, other.dir.yy))) > 90) {
	
	for (var len = 1; len < 200; len++) {
		var xx = len*other.dir.xx
		var yy = len*other.dir.yy
		if (!place_meeting(x+xx, y+yy, other.id)) {
			x += xx
			y += yy
			break
		}
	}
}