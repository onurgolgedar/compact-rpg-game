function create_textbox(xx, yy, text, owner, offset_x, offset_y) {
	if (offset_x == undefined)
		offset_x = 0
	if (offset_y == undefined)
		offset_y = 0
	
	var textbox = instance_create_depth(xx, yy, 0, objText)
	textbox.text = text
	textbox.owner = owner
	textbox.offset_x = offset_x
	textbox.offset_y = offset_y
	
	return textbox
}