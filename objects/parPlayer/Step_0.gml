event_inherited()

var _delta = global.delta_COMMON

if (skill[0] != undefined) {
	if (skill[0]+_delta < 1)
		skill[0] += _delta
	else
		skill[0] = undefined
}