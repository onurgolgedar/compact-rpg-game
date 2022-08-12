function_call_init_COMMON()

function main_loop() {
	var _period = floor(global.gameTime*100)/10
	if (_period mod 20 >= 10)
		global.period = _period mod 10
	else
		global.period = 10-(_period mod 10)
	
	global.gameTime += 1/10
	
	with (parClickableNPC)
		hover = is_mouse_on()
		
	with (contDrawGUi)
		isChatSelVisible = abs(global.period-5) > 2

	function_call_COMMON(main_loop, 1/10, true)
	
	if (instance_exists(objPlayer) and global.drawEventEnabled and room != roomMenu) {
		var dis = point_distance(objPlayer.xx, objPlayer.yy, camera_get_view_x(global.camera)+camera_get_view_width(global.camera)/2, camera_get_view_y(global.camera)+camera_get_view_height(global.camera)/2)
		if (dis > 300 and !global.drawServer)
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
}
function_call_COMMON(main_loop, 1/10, true)

game_set_speed(60, gamespeed_fps) // Max: 240
audio_listener_orientation(0, 0, 1, 0, -1, 0)
audio_falloff_set_model(audio_falloff_exponent_distance_clamped)

global.chatActive = false
global.chatHistory = ds_list_create()

global.delta_COMMON = delta()
global.clientName = ""
global.playerNames = ds_map_create()
global.playerInstances = ds_map_create()
global.npcInstances = ds_map_create()
global.activeQuests_player = ds_map_create()
	
cam_spd = 1
global.period = 0
global.gameTime = 0

for (var i = 0; i < 5; i++)
	global.skill_sprite[i] = sprNothingness

global.boxes = undefined
global.boxes_skill = undefined

global.level = 1
global.skillPoints = 0
global.statPoints = 0