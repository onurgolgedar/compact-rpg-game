if (!is_in_game_room_COMMON())
	exit

if (!global.drawServer_SERVER) {
	targetZoom = targetZoom_default
	alarm[0] = 1
}