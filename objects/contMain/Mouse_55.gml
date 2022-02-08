if (!global.drawServer) {
	var limitZoom_h = 768

	camera_set_view_size(global.camera, floor(limitZoom_h*aspectRatio), limitZoom_h)
	camera_set_view_border(global.camera, camera_get_view_width(global.camera)/2, camera_get_view_height(global.camera)/2)

	lighting_set_dirty(true)
}