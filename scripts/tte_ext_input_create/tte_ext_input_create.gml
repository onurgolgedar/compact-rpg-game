function tte_ext_input_create(){
	tte_surface = -1

	on_changed = noone

	lines = ds_list_create()
	ds_list_add(lines, "")

	focus = false

	hover = false
	hover_x = 0
	hover_y = 0

	column = string_length(lines[| 0])+1
	line = 0

	caretVisible = false
	caretDelay = 500
	caretTimer = current_time
	forceCaret = false

	repeatKey = vk_nokey
	repeatFirstDelay = 500
	repeatDelay = 50
	repeatTimer = current_time

	selVisible = false
	selStartCol = 1
	selStartLine = 1
	selEndCol = 1
	selEndLine = 1
	selAnchorLine = 1
	selAnchorCol = 1
	selDir = 0
	selDrag = false

	fg = c_white
	fg_alpha = 1
	bg = c_black
	bg_alpha = 0.7
	sel = $FFD0D0
	sel_alpha = 0.7

	scrollx = 0
	scrolly = 0
	update = false
}