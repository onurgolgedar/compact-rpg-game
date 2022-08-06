var value = 2.5*global.delta_COMMON
if (hp != maxHp) {
	if (hp+value <= maxHp)
		hp += value
	else
		hp = maxHp
}
	
value = 30*global.delta_COMMON
if (energy != maxEnergy) {
	if (energy+value <= maxEnergy)
		energy += value
	else
		energy = maxEnergy
}

value = 12*global.delta_COMMON
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
			var attack_x = lengthdir_x(115, other.image_angle)
			var attack_y = lengthdir_y(115, other.image_angle)
			
			var x2 = x+lengthdir_x(35, image_angle+50)
			var y2 = y+lengthdir_y(35, image_angle+50)
			
			var x3 = x+lengthdir_x(35, image_angle-50)
			var y3 = y+lengthdir_y(35, image_angle-50)
			
			if (point_distance(x, y, other.x+attack_x, other.y+attack_y) < 35
			    or point_distance(x, y, other.x+attack_x*3/5, other.y+attack_y*3/5) < 25
				or point_distance(x, y, other.x+attack_x*1/4, other.y+attack_y*1/4) < 25

				or point_distance(x2, y2, other.x+attack_x, other.y+attack_y) < 35
			    or point_distance(x2, y2, other.x+attack_x*3/5, other.y+attack_y*3/5) < 25
				or point_distance(x2, y2, other.x+attack_x*1/4, other.y+attack_y*1/4) < 25
				
				or point_distance(x3, y3, other.x+attack_x, other.y+attack_y) < 35
			    or point_distance(x3, y3, other.x+attack_x*3/5, other.y+attack_y*3/5) < 25
				or point_distance(x3, y3, other.x+attack_x*1/4, other.y+attack_y*1/4) < 25) {
					
				if (point_distance(x, y, other.x+attack_x, other.y+attack_y) < 35
				    or point_distance(x, y, other.x+attack_x*3/5, other.y+attack_y*3/5) < 25
					or point_distance(x, y, other.x+attack_x*1/4, other.y+attack_y*1/4) < 25)
					change_hp(-other.physicalPower)
				else
					change_hp(-other.physicalPower*0.8)
				
				var pow = 650+clamp(650-point_distance(x, y, other.x, other.y)/10*40, 0, 650)
				ds_map_add(spds, irandom(999999), {xx: lengthdir_x(pow, other.image_angle), yy: lengthdir_y(pow, other.image_angle)})
				
				net_server_send(SOCKET_ID_ALL, CODE_DAMAGED, json_stringify({ socketID: targetID, value: 1 }), BUFFER_TYPE_STRING)
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