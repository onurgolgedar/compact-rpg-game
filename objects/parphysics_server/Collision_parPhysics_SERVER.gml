var dir = point_direction(x, y, other.x, other.y)+180
var push = {xx: lengthdir_x(1, dir), yy: lengthdir_y(1, dir)}
for (var len = 1; len < 200; len++) {
	var xx = len*push.xx
	var yy = len*push.yy
	if (!place_meeting(x+xx, y+yy, other.id)) {
		x += xx/4.5
		y += yy/4.5
		break
	}
}