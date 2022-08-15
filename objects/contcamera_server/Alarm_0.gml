if (!global.drawServer_SERVER) {
	camera_set_view_target(global.camera, objPlayer)
	camera_set_view_speed(global.camera, -1, -1)
}
else {
	camera_set_view_target(global.camera, noone)
}