function show_messagebox(xx, yy, title, text, duration = -1) {
	var messageBox = instance_create_layer(xx, yy, "Windows", objMessageBox_window)
	messageBox.title = title
	messageBox.text = text
	messageBox.maxDuration = duration
	messageBox.duration = duration
	if (duration != -1)
		messageBox.alarm[1] = SEC
	
	var count = 1
	while (count > 0) {
		count--
		with (parWindow) {
			if (x == messageBox.x and y == messageBox.y and id != messageBox) {
				messageBox.x += 10
				messageBox.y += 10
				
				count++
			}
		}
	}
		
	with (messageBox)
		event_perform(ev_other, ev_user1)
		
	return messageBox
}