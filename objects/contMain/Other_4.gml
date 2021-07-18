#region Display Setup
aspectRatio = display_get_width()/display_get_height()

global.camera = camera_create()
view_set_camera(0, global.camera)

var scale = 1.15
var cameraWidth = 768*aspectRatio*scale
var cameraHeight = 768*scale
camera_set_view_size(global.camera, cameraWidth, cameraHeight)
camera_set_view_border(global.camera, camera_get_view_width(global.camera)/2, camera_get_view_height(global.camera)/2)
//camera_set_view_target(global.camera, objPlayer)
camera_set_view_speed(global.camera, 7, 7)

var quality = 1.4
surface_resize(application_surface, cameraWidth*quality/scale, cameraHeight*quality/scale)
display_set_gui_size(cameraWidth/scale, cameraHeight/scale)
window_set_size(cameraWidth/scale, cameraHeight/scale)

if (room == roomMenu)
	camera_set_view_pos(global.camera, room_width/2-cameraWidth/2, room_height/2-cameraHeight/2)
#endregion

if (global.boxes == undefined) {
	global.gold = 0
	global.boxes = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
	for (var i = 0; i < global.bc_hor_COMMON*global.pageCount_COMMON; i++)
		for (var j = 0; j < global.bc_ver_COMMON+2; j++)
			ds_grid_set(global.boxes, i, j, global.boxEmpty_COMMON)
}