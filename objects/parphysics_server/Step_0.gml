// Speeds
spd = { xx: 0, yy: 0 }
var _spds = ds_map_values_to_array(spds)
var _spds_keys = ds_map_keys_to_array(spds)
ds_size = array_length(_spds)
for (var i = 0; i < ds_size; i++) {
	var _spd = _spds[i]
	
	if (_spd.xx == 0 and _spd.yy == 0) {
		ds_map_delete(spds, _spds_keys[i])
		continue
	}
	
	spd.xx += _spd.xx
	spd.yy += _spd.yy
	
	var fric_dir = point_direction(0, 0, _spd.xx, _spd.yy)+180
	var fric_amb = 5000*global.delta_COMMON
	var fric = { xx: lengthdir_x(fric_amb, fric_dir), yy: lengthdir_y(fric_amb, fric_dir) }
	_spd.xx = _spd.xx+fric.xx
	_spd.yy = _spd.yy+fric.yy
	if (abs(_spd.xx) < fric_amb)
		_spd.xx = 0
	if (abs(_spd.yy) < fric_amb)
		_spd.yy = 0
}

spd_res.xx = spd.xx
spd_res.yy = spd.yy

spd_res.xx *= (1-onWater/2)
spd_res.yy *= (1-onWater/2)
	
x += spd_res.xx*global.delta_COMMON
y += spd_res.yy*global.delta_COMMON