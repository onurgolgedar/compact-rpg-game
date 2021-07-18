/// @param id
/// @param time
function destroy_effect(_id, time) {
	with (_id) {
		stop = true
		part_emitter_destroy_all(ps)
		alarm[11] = time // ? delta
	}
}
