event_inherited()

if (is_mouse_on() and !is_click_blocked()) {	
	if (buttonHovered_index != -1)
		switch (buttonHovered_index) {
			case -1000:
				if (buttonPage > 1)
					buttonPage--
				break
			
			case 1000:
				if (buttonPage < buttonMaxPage)
					buttonPage++
				break
			
			default:
				var button = ds_list_find_value(buttons, buttonHovered_index)
				answerIndex = buttonHovered_index
				with (owner)
					answer(other.answerIndex, dialogue_get_qKey_COMMON(other.messageID, other.dialogueNo), button.value, other.x+50, other.y+50)
				instance_destroy()
				break
		}
}
	
