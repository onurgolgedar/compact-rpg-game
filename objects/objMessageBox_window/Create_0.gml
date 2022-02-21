event_inherited()

function get_button_location(i, isVertical = 0) {	
	var _upButton_height = 0
	var _downButton_height = 0
	if (buttonCount > buttonMaxCount_perPage) {
		_upButton_height = upButton_height
		_downButton_height = downButton_height
	}
	
	if (!isVertical)
		return { xx: x+buttonWidth/2+offset+(i mod 2)*(width-buttonWidth-offset*2),
				 yy: y+titleHeight+offset+abs(textbox_content.height)+_upButton_height+buttonOffset*(buttonCount > buttonMaxCount_perPage)+buttonHeight/2+((i mod buttonMaxCount_perPage) div 2)*(buttonHeight+buttonOffset) }
	else
		return 0
}

title = ""
text = ""
textbox_content = undefined

offset = 4
titleHeight = 32
buttonHeight = 30
buttonWidth = 150
upButton_height = 24
downButton_height = 24
upButton_xx_rel = 0
upButton_yy_rel = 0
downButton_xx_rel = 0
downButton_yy_rel = 0
buttonOffset = 6
buttonMaxCount_perPage = 8
buttonPage = 1
buttonMaxPage = 1
buttonHovered_index = -1
buttonCount = 0
messageID = -1
dialogueNo = 1
dialogueSize = 1
dialogueOrderText = undefined
answerIndex = -1

width = 100
height = 100

maxDuration = -1
duration = -1

buttons = ds_list_create()