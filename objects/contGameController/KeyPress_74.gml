if (global.chatActive)
	exit

if (!instance_exists(objQuests_window)) {
	instance_create_layer(contDrawGUi.guiWidth-800, 140, "Windows", objQuests_window)
	audio_play_sound(sndWindowTick, 0, false)
}
else
	instance_destroy(objQuests_window)