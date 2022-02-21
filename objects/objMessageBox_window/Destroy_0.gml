if (textbox_content != undefined and instance_exists(textbox_content))
	instance_destroy(textbox_content)

event_inherited()

if (messageID != -1 and answerIndex != -1)
	show_message_client(messageID, owner, dialogueNo+1, answerIndex)