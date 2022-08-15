var dir = point_direction(x, y, other.x, other.y)+180
for (var len = 1; len < 200; len++) {
	var xx = len*lengthdir_x(1, dir)
	var yy = len*lengthdir_y(1, dir)
	if (!place_meeting(x+xx, y+yy, real(other.id))) {
		x += xx/4.5
		y += yy/4.5
		break
	}
}