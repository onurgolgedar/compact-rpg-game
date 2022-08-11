if (global.chatActive)
	exit

if (!instance_exists(objCharacter_window)) {
	audio_play_sound(sndWindowTick, 0, false)
	instance_create_layer(415, 140, "Windows", objCharacter_window)
}
else
	instance_destroy(objCharacter_window)