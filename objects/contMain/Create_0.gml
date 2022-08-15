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

global.held_box_i = undefined
global.held_box_j = undefined
global.held_box = undefined
global.held_from_assetName = undefined
global.held_from = undefined
	
global.period = 0
global.gameTime = 0

for (var i = 0; i < 5; i++)
	global.skill_sprite[i] = sprNothingness

global.boxes = undefined
global.boxes_skill = undefined

global.level = 1
global.skillPoints = 0
global.statPoints = 0