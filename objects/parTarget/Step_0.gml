var _delta = global.delta_COMMON

var ds_size = ds_list_size(texts)
for (var i = 0; i < ds_size; i++) {
	var text = texts[| i]
	
	text.xx += text.spd_x*_delta
	text.yy += text.spd_y*_delta
	
	text.spd_x *= 0.9
	text.spd_y *= 0.9
	
	if (abs(text.spd_x) < _delta)
		text.spd_x = 0
	if (abs(text.spd_y) < _delta)
		text.spd_y = 0
		
	if (text.life-_delta > 0)
		text.life -= _delta
	else {
		ds_list_delete(texts, i)
		i--
		ds_size--
	}
}