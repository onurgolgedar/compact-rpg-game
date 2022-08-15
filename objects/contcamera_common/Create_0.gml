function main_loop() {
	if (instance_exists(objPlayer) and global.drawEventEnabled_SERVER and is_in_game_room_COMMON()) {
		var dis = point_distance(objPlayer.xx, objPlayer.yy, camera_get_view_x(global.camera)+camera_get_view_width(global.camera)/2, camera_get_view_y(global.camera)+camera_get_view_height(global.camera)/2)
		if (dis > 300 and !global.drawServer_SERVER)
			camera_set_view_pos(global.camera, objPlayer.xx-camera_get_view_width(global.camera)/2, objPlayer.yy-camera_get_view_height(global.camera)/2)
		else {
			var cam_spd_target = min(1.5+power(dis/20, 2), 12)*60/room_speed
			if (abs(cam_spd_target-cam_spd) > 0.2)
				cam_spd = lerp(cam_spd, cam_spd_target, 0.33)
			else
				cam_spd = cam_spd_target
				
			camera_set_view_speed(global.camera, cam_spd, cam_spd)
		}
	}
	
	function_call_COMMON(main_loop, 1/10, true)
}
function_call_COMMON(main_loop, 1/10, true)

cam_spd = 1
targetZoom = undefined
targetZoom_default = 768
aspectRatio = -1