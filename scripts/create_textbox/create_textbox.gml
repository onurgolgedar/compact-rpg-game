function create_textbox(text, owner, offset_x = 0, offset_y = 0, owner_isOnGUi = false) {	
	var textbox = instance_create_depth(0, 0, 0, objText)
	textbox.text = text
	textbox.owner = owner
	textbox.offset_x = offset_x
	textbox.offset_y = offset_y
	textbox.owner_isOnGUi = owner_isOnGUi
	
	return textbox
}