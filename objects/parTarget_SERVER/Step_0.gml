var value = 2*global.delta_COMMON
if (hp != maxHp) {
	if (hp+value <= maxHp)
		hp += value
	else
		hp = maxHp
}
	
value = 25*global.delta_COMMON
if (energy != maxEnergy) {
	if (energy+value <= maxEnergy)
		energy += value
	else
		energy = maxEnergy
}

value = 10*global.delta_COMMON
if (mana != maxMana) {
	if (mana+value <= maxMana)
		mana += value
	else
		mana = maxMana
}
	
if (attackSpeed_rem-global.delta_COMMON > 0)
	attackSpeed_rem -= global.delta_COMMON
else
	attackSpeed_rem = 0

if (attackTimer-global.delta_COMMON > 0)
	attackTimer -= global.delta_COMMON
else if (attackTimer != 0) {
	attackTimer = 0
	
	with (parTarget_SERVER) {
		if (id != other.id) {
			var attack_x = lengthdir_x(114, other.image_angle)
			var attack_y = lengthdir_y(114, other.image_angle)
			if (point_distance(x, y, other.x+attack_x, other.y+attack_y) < 37
				or point_distance(x, y, other.x+attack_x*2/3, other.y+attack_y*2/3) < 55
				or point_distance(x, y, other.x+attack_x*1/3, other.y+attack_y*1/3) < 65
				or point_distance(x, y, other.x+attack_x*1/4, other.y+attack_y*1/4) < 77) {
				change_hp(-other.physicalPower)
				
				var pow = 600+clamp(600-point_distance(x, y, other.x, other.y)/10*30, 0, 600)
				ds_map_add(spds, irandom(999999), {xx: lengthdir_x(pow, other.image_angle), yy: lengthdir_y(pow, other.image_angle)})
			}
		}
	}
}

// Speeds
spd = {xx: 0, yy: 0}
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
	var fric_amb = 200
	var fric = {xx: lengthdir_x(fric_amb, fric_dir), yy: lengthdir_y(fric_amb, fric_dir)}
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