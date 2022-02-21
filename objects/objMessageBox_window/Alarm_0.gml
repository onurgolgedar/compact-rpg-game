if (textbox_content != undefined and instance_exists(textbox_content)) {
	var buttonCount = ds_list_size(buttons)
	var buttonLocation_last = get_button_location(buttonMaxCount_perPage-1)
	
	var _upButton_height = 0
	var _downButton_height = 0
	if (buttonCount > buttonMaxCount_perPage) {
		_upButton_height = upButton_height
		_downButton_height = downButton_height
	}
	
	width = max(abs(textbox_content.width), 2*(buttonWidth+buttonOffset))
	height = abs(textbox_content.height)+offset+titleHeight+clamp((buttonCount+1) div 2, 0, 4)*(buttonHeight+buttonOffset)
			 +_downButton_height+buttonOffset*(buttonCount > buttonMaxCount_perPage)+_upButton_height+offset*(buttonCount > buttonMaxCount_perPage)
			 
	upButton_xx_rel = width/2
	upButton_yy_rel = titleHeight+buttonHeight/2+abs(textbox_content.height)+offset
		
	downButton_xx_rel = width/2
	downButton_yy_rel = buttonHeight/2+offset+downButton_height/2+buttonLocation_last.yy-y
	
	dialogueOrderText = strret(" ["+string(dialogueNo)+"/"+string(dialogueSize)+"] ", messageID != -1 and dialogueSize != 1)
}