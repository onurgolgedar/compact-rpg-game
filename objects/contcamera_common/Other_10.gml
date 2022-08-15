#region Display Setup
aspectRatio = display_get_width()/display_get_height()

/*if (camera_get_active() != undefined)
	camera_destroy(camera_get_active())*/
global.camera = camera_create()
view_set_camera(0, global.camera)

var cam_scale = 1.1
var cameraWidth = 768*aspectRatio*cam_scale
var cameraHeight = 768*cam_scale
camera_set_view_size(global.camera, cameraWidth, cameraHeight)
camera_set_view_border(global.camera, camera_get_view_width(global.camera)/2, camera_get_view_height(global.camera)/2)
camera_set_view_target(global.camera, objPlayer)
camera_set_view_speed(global.camera, -1, -1)

targetZoom = cameraHeight
targetZoom_default = targetZoom

var quality = 1//1.35
var gui_scale = room == roomGame ? 1.25 : 1.15
surface_resize(application_surface, cameraWidth*quality/cam_scale, cameraHeight*quality/cam_scale)
display_set_gui_size(cameraWidth/cam_scale*gui_scale, cameraHeight/cam_scale*gui_scale)
window_set_size(cameraWidth/cam_scale, cameraHeight/cam_scale)

if (!is_in_game_room_COMMON())
	camera_set_view_pos(global.camera, room_width/2-cameraWidth/2, room_height/2-cameraHeight/2)
#endregion

alarm[0] = 3