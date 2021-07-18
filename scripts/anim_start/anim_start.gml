/// @function anim_start(anim, time*, instance*, style*)
function anim_start(anim, time, instance, style) {
	if (instance == undefined)
		instance = id
	
	if (style == undefined)
		style = 0
		
	var _anim = instance_create(0, 0, anim)
	
	with (_anim) {
		_anim.owner = instance
		_anim.style = style
		_anim.time = time
		event_user(0)
	}
	
	return _anim
}