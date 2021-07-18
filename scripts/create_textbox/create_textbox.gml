function create_textbox(xx, yy, text, owner) {
	var textbox = instance_create_depth(xx, yy, 0, objText)
	textbox.text = text
	textbox.owner = owner
	
	return textbox
}