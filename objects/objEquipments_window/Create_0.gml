event_inherited()

function is_mouse_on_box(i, j) {
	var box_positions = get_box_positions(i, j)
	var xx_start = box_positions.xx_start
	var xx_end = box_positions.xx_end
	var yy_start = box_positions.yy_start
	var yy_end = box_positions.yy_end
			
	return global.dmx > xx_start and global.dmx < xx_end and global.dmy > yy_start and global.dmy < yy_end
}

function get_box_positions(i, j) {
	j -= global.bc_ver_COMMON
	
	// Necklace
	if (i == 0 and j == 0) {
		i += 1
	}
	
	// Sword
	else if (i == 1 and j == 0) {
		i -= 1
		j += 1
	}
	
	// Clothes
	else if (i == 2 and j == 0) {
		i -= 1
		j += 1
	}
	
	// Shield
	else if (i == 3 and j == 0) {
		i -= 1
		j += 1
	}
	
	// Matter
	else if (i == 4 and j == 0) {
		i -= 3
		j += 2
	}
	
	var _xx_start = 2*offset+x+i*(boxWidth+boxBetween)
	var _xx_end = 2*offset+x+(i+1)*boxWidth+i*boxBetween
	var _yy_start = 3*offset+height_ext_top+y+j*(boxHeight+boxBetween)
	var _yy_end = 3*offset+height_ext_top+y+(j+1)*boxHeight+j*boxBetween
	
	return {xx_start: _xx_start, yy_start: _yy_start, xx_end: _xx_end, yy_end: _yy_end, xx_center: (_xx_start+_xx_end)/2, yy_center: (_yy_start+_yy_end)/2}
}

function main_loop() {
	var found = false
	for (var i = 0; i < global.bc_hor_COMMON and !found; i++) {
		for (var j = global.bc_ver_COMMON; j < global.bc_ver_COMMON+2; j++) {
			if (boxes_alpha[i][j] < 1)
				boxes_alpha[i][j] += 0.25
			
			var box = ds_grid_get(boxes, i, j)
			if (box.item != undefined and is_mouse_on() and !is_click_blocked() and is_mouse_on_box(i, j)) {
				found = true
				
				if (boxFocused != box) {
					boxFocused = box
					boxFocused_i = i
					boxFocused_j = j
				
					if (boxFocused_textbox != undefined)
						instance_destroy(boxFocused_textbox)
					
					boxFocused_textbox = create_textbox(get_item_text(boxFocused.item), contCursor.id)
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
	
	function_call(main_loop, 1/20, true)
}
function_call(main_loop, 1/20, true)

title = "EQUIPMENTS"

boxWidth = 50
boxHeight = 50
boxBetween = 6
	
boxFocused = undefined
boxFocused_textbox = undefined
boxFocused_i = undefined
boxFocused_j = undefined

offset = 4
height_ext_bot = 0
height_ext_bot_more = 0
height_ext_top = 28

width = 3*boxWidth+3*boxBetween+offset*2
height = 3*boxHeight+2*boxBetween+offset*3+height_ext_bot+offset+height_ext_bot_more+offset+height_ext_top

boxes = objInventory_window.boxes
boxes_alpha = objInventory_window.boxes_alpha