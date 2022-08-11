if (room == roomMenu)
	exit
	
var zoom = camera_get_view_height(global.camera)
var cw = camera_get_view_width(global.camera)
var ch = camera_get_view_height(global.camera)
var stop = false

if (zoom > targetZoom) {
	var zoomLimit = floor(768*0.6)
	var value = abs(1-targetZoom/zoom) < 0.01 ? targetZoom/zoom : lerp(targetZoom, zoom, 0.9)/zoom

	if (zoom > zoomLimit) {	
		camera_set_view_size(global.camera, cw*value, ch*value)		
		camera_set_view_border(global.camera, camera_get_view_width(global.camera)/2, camera_get_view_height(global.camera)/2)
	}
	else if (camera_get_view_height(global.camera) != zoomLimit) {
		camera_set_view_size(global.camera, zoomLimit*aspectRatio, zoomLimit)
				camera_set_view_border(global.camera, camera_get_view_width(global.camera)/2, camera_get_view_height(global.camera)/2)
		
		stop = true
		targetZoom = zoomLimit
	}
	
	camera_set_view_pos(global.camera, camera_get_view_x(global.camera)+(cw-camera_get_view_width(global.camera))/2, camera_get_view_y(global.camera)+(ch-camera_get_view_height(global.camera))/2)
}
else {
	var zoomLimit = floor(768*1.4*(1+2*global.drawServer))
	var value = abs(1-targetZoom/zoom) < 0.01 ? targetZoom/zoom : lerp(targetZoom, zoom, 0.9)/zoom

	if (zoom < zoomLimit) {	
		camera_set_view_size(global.camera, cw*value, ch*value)
		camera_set_view_border(global.camera, camera_get_view_width(global.camera)/2, camera_get_view_height(global.camera)/2)
	}
	else if (camera_get_view_height(global.camera) != zoomLimit) {
		camera_set_view_size(global.camera, zoomLimit*aspectRatio, zoomLimit)	
		camera_set_view_border(global.camera, camera_get_view_width(global.camera)/2, camera_get_view_height(global.camera)/2)
		
		stop = true
		targetZoom = zoomLimit
	}

	camera_set_view_pos(global.camera, camera_get_view_x(global.camera)+(cw-camera_get_view_width(global.camera))/2, camera_get_view_y(global.camera)+(ch-camera_get_view_height(global.camera))/2)
}

if (targetZoom != zoom and !stop)
	alarm[1] = 1