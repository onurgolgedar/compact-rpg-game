if (!global.drawServer) {
	var limitZoom_h = 768

	camera_set_view_size(global.camera, floor(limitZoom_h*aspectRatio), limitZoom_h)
	camera_set_view_border(global.camera, camera_get_view_width(global.camera)/2, camera_get_view_height(global.camera)/2)

	lighting_set_dirty(true)
}

var messageBox = instance_create_layer(250, 250, "Windows", objMessageBox_window)
with (messageBox)
	event_perform(ev_other, ev_user1)