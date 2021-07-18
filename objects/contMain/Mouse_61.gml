var limitZoom_h = floor(768*1.3)*(1+2*global.drawServer)
var value = 1.05

var cw = camera_get_view_width(global.camera)
var ch = camera_get_view_height(global.camera)

if (camera_get_view_height(global.camera)*value < limitZoom_h) {	
	camera_set_view_size(global.camera, floor(cw*value), floor(ch*value))
    
	camera_set_view_border(global.camera, cw/2, ch/2)
}
else if (camera_get_view_height(global.camera) != limitZoom_h) {
	camera_set_view_size(global.camera, floor(limitZoom_h*aspectRatio), limitZoom_h)
    
	camera_set_view_border(global.camera, cw/2, ch/2)
}

camera_set_view_pos(global.camera, camera_get_view_x(global.camera)+(cw-camera_get_view_width(global.camera))/2, camera_get_view_y(global.camera)+(ch-camera_get_view_height(global.camera))/2)