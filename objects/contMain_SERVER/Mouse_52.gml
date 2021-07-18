if (global.drawServer) {
	camera_set_view_pos(global.camera, camera_first_x-mouse_x+wheel_x, camera_first_y-mouse_y+wheel_y)
	camera_first_x = camera_get_view_x(global.camera)
	camera_first_y = camera_get_view_y(global.camera)
}