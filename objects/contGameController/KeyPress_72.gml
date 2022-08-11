if (global.chatActive)
	exit

if (!instance_exists(objConnection_window)) {
	instance_create_layer(615, 140, "Windows", objConnection_window)
	audio_play_sound(sndWindowTick, 0, false)
}
else
	instance_destroy(objConnection_window)