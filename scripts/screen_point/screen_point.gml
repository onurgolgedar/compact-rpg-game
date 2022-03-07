function screen_point(value, isVertical) {
	var cam = global.camera
	var scale = camera_get_view_height(cam)/window_get_height()

	if (isVertical)
		return (value*scale-camera_get_view_y(cam))*display_get_gui_height()/camera_get_view_height(cam)

	return (value*scale-camera_get_view_x(cam))*display_get_gui_width()/camera_get_view_width(cam)
}