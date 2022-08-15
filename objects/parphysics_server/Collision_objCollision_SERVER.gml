if ((spd_res.xx == 0 and spd_res.yy == 0)
	or abs(angle_difference(point_direction(0, 0, spd_res.xx, spd_res.yy), point_direction(0, 0, other.dir.xx, other.dir.yy))) > 90) {
	
	for (var len = 1; len < 200; len++) {
		var xx = len*other.dir.xx
		var yy = len*other.dir.yy
		if (!place_meeting(x+xx, y+yy, real(other.id))) {
			x += xx
			y += yy
			break
		}
	}
	
	var _spds = ds_map_values_to_array(spds)
	var _spds_keys = ds_map_keys_to_array(spds)
	var ds_size = array_length(_spds)
	
	for (var i = 0; i < ds_size; i++) {
		var _spd = spds[? _spds_keys[i]]

		var dir1 = point_direction(0, 0, _spd.xx, _spd.yy)
		var dir2 = point_direction(0, 0, other.dir.xx, other.dir.yy)
		
		if (abs(angle_difference(dir1, dir2)) > 90) {
			for (var len = 1; len < 100; len++) {
				var xx = len*other.dir.xx*6
				var yy = len*other.dir.yy*6
			
				var k = _spd.xx+xx
				var t = _spd.yy+yy
				var dir3 = point_direction(0, 0, k, t)
			
				if (abs(angle_difference(dir2, dir3)) <= 90)  {
					delete spds[? _spds_keys[i]]
					spds[? _spds_keys[i]] = { xx: k, yy: t }					
					break
				}
			}
		}
		else {
			for (var len = 1; len < 100; len++) {
				var xx = len*other.dir.xx*6
				var yy = len*other.dir.yy*6
			
				var k = _spd.xx-xx
				var t = _spd.yy-yy
				var dir3 = point_direction(0, 0, k, t)
			
				if (abs(angle_difference(dir2, dir3)) > 90)  {
					delete spds[? _spds_keys[i]]
					spds[? _spds_keys[i]] = { xx: k+other.dir.xx*5*elasticity, yy: t+other.dir.yy*5*elasticity }	
					break
				}
			}
		}
	}
}