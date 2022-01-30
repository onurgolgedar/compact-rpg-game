function refresh() {
	isRefreshing = true
	instance_destroy()
	isRefreshing = false
	
	var _depth = depth
	var _onFront = onFront
	var window = instance_create_layer(x, y, "Windows", object_index)
	window.isRefreshing = true
	window.depth = _depth
	window.onFront = _onFront
	
	return window
}

function is_mouse_on() {
	return global.dmx > x and global.dmx < x+width and global.dmy > y and global.dmy < y+height
}

function alpha_loop() {
	if (_alpha_factor < 1)
		_alpha_factor += 0.3
	image_alpha = _alpha_factor*_alpha_factor
		
	function_call(alpha_loop, 1/30, true)
}
function_call(alpha_loop, 1/30, true)


function after_creation() {
	event_user(0)
}
function_call(after_creation, 1, false)

function bring_forward() {
	onFront = true
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

image_alpha = 0
_alpha_factor = 0
depth -= instance_number(parWindow)*2