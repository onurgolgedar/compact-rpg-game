function_call_init_COMMON()

function main_loop() {
	var _period = floor(global.gameTime*100)/10
	if (_period mod 20 >= 10)
		global.period = _period mod 10
	else
		global.period = 10-(_period mod 10)
	
	global.gameTime += 1/20
	
	with (parClickableNPC)
		hover = is_mouse_on()

	function_call_COMMON(main_loop, 1/20, true)
	
if (instance_exists(objPlayer)) {
		var dis = point_distance(objPlayer.x, objPlayer.y, camera_get_view_x(global.camera)+camera_get_view_width(global.camera)/2, camera_get_view_y(global.camera)+camera_get_view_height(global.camera)/2)
		if (dis < 30)
			camera_set_view_speed(global.camera, 3.9, 3.9)
		else {
			var spd = 2.9+dis/30*dis/30
			camera_set_view_speed(global.camera, spd, spd)
		}
	}
}
function_call_COMMON(main_loop, 1/20, true)

game_set_speed(50, gamespeed_fps) // Max: 240

global.ping_udp = 0
global.networkErrors_count = 0
global.delta_COMMON = delta()
global.clientName = ""
global.playerNames = ds_map_create()
global.playerInstances = ds_map_create()
global.creatureInstances = ds_map_create()
global.activeQuests_player = ds_map_create()

global.period = 0
global.gameTime = 0

for (var i = 0; i < 5; i++)
	global.skill_sprite[i] = sprNothingness

global.boxes = undefined
global.boxes_skill = undefined

global.level = 1
global.skillPoints = 3