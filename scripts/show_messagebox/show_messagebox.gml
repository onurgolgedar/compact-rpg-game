function show_messagebox(xx, yy, title, text, duration = -1) {
	var messageBox = instance_create_layer(xx, yy, "Windows", objMessageBox_window)
	messageBox.title = title
	messageBox.text = text
	messageBox.maxDuration = duration
	messageBox.duration = duration
	if (duration != -1)
		messageBox.alarm[1] = SEC
		
	with (messageBox)
		event_perform(ev_other, ev_user1)
}