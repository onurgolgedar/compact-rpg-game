function create_textbox(text, owner, offset_x, offset_y, owner_isOnGUI) {
	if (offset_x == undefined)
		offset_x = 0
	if (offset_y == undefined)
		offset_y = 0
	if (owner_isOnGUI == undefined)
		owner_isOnGUI = false
	
	var textbox = instance_create_depth(0, 0, 0, objText)
	textbox.text = text
	textbox.owner = owner
	textbox.offset_x = offset_x
	textbox.offset_y = offset_y
	textbox.owner_isOnGUI = owner_isOnGUI
	
	return textbox
}