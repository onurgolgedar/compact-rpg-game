event_inherited()

function inventory_refresh() {
	var eq_x = undefined
	var eq_y = undefined
	with (objEquipment_window) {
		eq_x = x
		eq_y = y
	}
	
	var window = refresh()
	window.page = page
	
	if (eq_x != undefined)
		return instance_create_layer(eq_x, eq_y, "Windows", objEquipment_window)
		
	return window
}

function is_mouse_on_box(i, j) {
	var box_positions = get_box_positions(i, j)
	var xx_start = box_positions.xx_start
	var xx_end = box_positions.xx_end
	var yy_start = box_positions.yy_start
	var yy_end = box_positions.yy_end
			
	return global.dmx > xx_start and global.dmx < xx_end and global.dmy > yy_start and global.dmy < yy_end
}

function get_box_positions(i, j) {
	i = i mod global.bc_hor_COMMON
	j = j mod global.bc_ver_COMMON
	
	var _xx_start = 2*offset+x+i*(boxWidth+boxBetween)
	var _xx_end = 2*offset+x+(i+1)*boxWidth+i*boxBetween
	var _yy_start = 3*offset+height_ext_top+y+j*(boxHeight+boxBetween)
	var _yy_end = 3*offset+height_ext_top+y+(j+1)*boxHeight+j*boxBetween
	
	return {xx_start: _xx_start, yy_start: _yy_start, xx_end: _xx_end, yy_end: _yy_end, xx_center: (_xx_start+_xx_end)/2, yy_center: (_yy_start+_yy_end)/2}
}

function main_loop() {
	var found = false
	for (var i = global.bc_hor_COMMON*(page-1); i < global.bc_hor_COMMON*page and !found; i++) {
		for (var j = 0; j < global.bc_ver_COMMON; j++) {
			if (boxes_alpha[i][j] < 1)
				boxes_alpha[i][j] += 0.25
			
			var box = ds_grid_get(boxes, i, j)
			if (box.item != undefined and is_mouse_on_box(i, j)) {
				found = true
				
				if (boxFocused != box) {
					boxFocused = box
					boxFocused_i = i
					boxFocused_j = j
				
					if (boxFocused_textbox != undefined)
						instance_destroy(boxFocused_textbox)
					
					boxFocused_textbox = create_textbox(0, 0, get_item_text(boxFocused.item), contCursor.id)
				}
				
				break
			}
		}
	}
	
	if (!found) {
		if (boxFocused_textbox != undefined)
			instance_destroy(boxFocused_textbox)
			
		boxFocused = undefined
		boxFocused_textbox = undefined
		boxFocused_i = undefined
		boxFocused_j = undefined
	}
	
	if (global.held_box != undefined and mouseOnButton < pageCount)
		page = mouseOnButton+1

	function_call(main_loop, 1/20, true)
}
function_call(main_loop, 1/20, true)

title = "Inventory"
pageCount = global.pageCount_COMMON
page = 1

boxWidth = 50
boxHeight = 50
boxBetween = 6
	
boxFocused = undefined
boxFocused_textbox = undefined
boxFocused_i = undefined
boxFocused_j = undefined

offset = 4
height_ext_bot = 100
height_ext_bot_more = 42
height_ext_top = 57

width = global.bc_hor_COMMON*boxWidth+(global.bc_hor_COMMON-1)*boxBetween+offset*4
height = global.bc_ver_COMMON*boxHeight+(global.bc_ver_COMMON-1)*boxBetween+offset*2+height_ext_bot+offset+height_ext_bot_more+offset+height_ext_top+offset

boxes = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
boxes_alpha = undefined
for (var i = 0; i < global.bc_hor_COMMON*global.pageCount_COMMON; i++) {
	for (var j = 0; j < global.bc_ver_COMMON+2; j++) {
		var box = ds_grid_get(global.boxes, i, j)
		boxes_alpha[i][j] = 1
		
		ds_grid_set(boxes, i, j, box)
	}
}