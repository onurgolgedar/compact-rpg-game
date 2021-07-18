var target

var spd_amb1 = point_distance(0, 0, spd.xx, spd.yy)
var spd_amb2 = point_distance(0, 0, other.spd.xx, other.spd.yy)
if (spd_amb1 >= spd_amb2)
	target = other.id
else
	target = id
	
with (target) {
	var dir_negative = point_direction(x, y, other.x, other.y)+180
	
	var cosx = lengthdir_x(1, dir_negative)
	var sinx = lengthdir_y(1, dir_negative)
	var len 
	for (len = 1; len < 200; len++) {
		var xx = len*cosx
		var yy = len*sinx

		if (!place_meeting(x+xx, y+yy, other.id)) {
			x += xx
			y += yy
			break
		}
	}
	
	if (spd_amb1 != 0 or spd_amb2 != 0) {
		spd_res = {xx: 0, yy: 0}
		other.spd_res = {xx: 0, yy: 0}
	
		var spd_new = {xx: (spd.xx+other.spd.xx)/2, yy: (spd.yy+other.spd.yy)/2}
		ds_map_clear(spds)
		ds_map_add(spds, irandom(999999), spd_new)
	 
		ds_map_clear(other.spds)
		ds_map_add(other.spds, irandom(999999), spd_new)
	}
}