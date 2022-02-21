function show_questionbox(xx, yy, title, text, owner, messageID, buttonsArray, duration = -1, isVertical = false) {
	var messageBox = show_messagebox(xx, yy, title, text, duration)
	
	if (buttonsArray != undefined)
		for (var i = 0; i < array_length(buttonsArray); i++)
			if (buttonsArray[i].text != undefined and buttonsArray[i].text != "")
				ds_list_add(messageBox.buttons, buttonsArray[i])
	
	messageBox.owner = owner
	messageBox.buttonMaxPage = ((ds_list_size(messageBox.buttons)-1) div messageBox.buttonMaxCount_perPage)+1
	messageBox.buttonCount = ds_list_size(messageBox.buttons)
	messageBox.isVertical = isVertical
	messageBox.messageID = messageID
	
	return messageBox
}