if (global.chatActive) {
	if (string_width(keyboard_string) > 314) {
		while (string_width(keyboard_string) > 314)
			keyboard_string = string_copy(keyboard_string, 1, string_length(keyboard_string)-1)
	}
}