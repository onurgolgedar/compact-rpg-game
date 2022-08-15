function destroy_effect(effect, time) {
	with (effect) {
		stop = true
		part_emitter_destroy_all(ps)
		alarm[11] = time // ? delta
	}
}