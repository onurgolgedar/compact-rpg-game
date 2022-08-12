if (!keyboard_check(vk_alt) and global.gameTime > 2 and room == roomGame) {
	if (global.chatActive and keyboard_string != "")
		net_client_send(_CODE_CHAT, json_stringify({ title: global.clientName, txt: keyboard_string }), BUFFER_TYPE_STRING)

	global.chatActive = !global.chatActive

	keyboard_string = ""
	io_clear()
}