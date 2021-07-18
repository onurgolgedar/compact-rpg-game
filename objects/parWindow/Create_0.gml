function refresh() {
	instance_destroy()
	return instance_create_layer(x, y, "Windows", object_index)
}

function is_mouse_on() {
	return global.dmx > x and global.dmx < x+width and global.dmy > y and global.dmy < y+height
}

mouseOnButton = undefined
isHeld = false
held_offset_x = undefined
held_offset_y = undefined

onFront = true
minDepth = 999
owner = undefined

depth -= instance_number(parWindow)*2
event_user(0)