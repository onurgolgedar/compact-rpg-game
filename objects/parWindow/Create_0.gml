function refresh() {
	isRefreshing = true
	instance_destroy()
	isRefreshing = false
	
	var _depth = depth
	var _onFront = onFront
	var window = instance_create_layer(x, y, "Windows", object_index)
	window.alarm[11] = -1
	window.depth = _depth
	window.onFront = _onFront
	
	return window
}

function is_mouse_on() {
	return global.dmx > x and global.dmx < x+width and global.dmy > y and global.dmy < y+height
}

mouseOnButton = undefined
isHeld = false
held_offset_x = undefined
held_offset_y = undefined
isOnExitButton = false

isRefreshing = false
onFront = false
minDepth = 999
owner = undefined

width = undefined
height = undefined

depth -= instance_number(parWindow)*2
alarm[11] = 1