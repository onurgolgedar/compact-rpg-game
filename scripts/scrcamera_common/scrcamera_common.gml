function camera_set_zoom(height, aspectRatio){
	camera_set_view_size(global.camera, height*aspectRatio, height)	
	camera_set_view_border(global.camera, camera_get_view_width(global.camera)/2, camera_get_view_height(global.camera)/2)
	with (contCamera_COMMON)
		alarm[0] = 1
}