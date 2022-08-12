if (moving and real(other.id) == collector) {
	if (!audio_is_playing(sndCoin))
		sound_play_at(sndCoin, x, y, false)
	instance_destroy()
}