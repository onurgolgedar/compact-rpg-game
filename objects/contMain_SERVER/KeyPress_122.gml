global.drawServer = !global.drawServer
if (!global.drawServer) {
	camera_set_view_target(global.camera, objPlayer)
	camera_set_view_speed(global.camera, -1, -1)
}
else {
	camera_set_view_target(global.camera, noone)
}

with (all) {
	if (string_count("_SERVER", object_get_name(object_index)))
		visible = global.drawServer
}