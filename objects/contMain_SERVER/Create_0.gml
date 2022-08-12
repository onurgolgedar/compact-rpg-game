counter = 0
function main_loop() {
	var ds_size = db_get_table_size(global.DB_SRV_TABLE_players)
	for (var i = 0; i < ds_size; i++) {
		var _row = db_get_row_by_index(global.DB_SRV_TABLE_players, i)
		var dt = _row[? PLAYERS_DEATHTIMER_SERVER]
		var sid = _row[? PLAYERS_SOCKETID_SERVER]
		
		if (dt > 0) {
			var dec = 3/room_speed
			_row[? PLAYERS_DEATHTIMER_SERVER] -= dec
			dt -= dec
		
			if (dt <= 0) {
				if (sid == global.socketID_player and (!global.drawEventEnabled or global.drawServer))
					_row[? PLAYERS_DEATHTIMER_SERVER] = 1
				else
					player_spawn_SERVER(sid)
			}
		}
	}

	tell_all_pl_positions_SERVER()
	
	if (counter % 2 == 0) {
		tell_all_pl_angles_SERVER()
		tell_all_npc_positions_SERVER()
	}

	if (counter % 3 == 0) {
		tell_all_npc_angles_SERVER()
		
		with (objPlayer_SERVER) {
			var ds_size = array_length(skills)
			for (var i = 0; i < ds_size; i++) {
				var skill = skills[i]
				if (skill != undefined)
					net_server_send(socketID, CODE_SKILL_INFO, json_stringify({ index: skill.index, key: i, code: skill.code, cooldownmax: skill.cooldownmax, energy: skill.energy, mana: skill.mana, cooldown: skill.cooldown, upgrade: skill.upgrade }), BUFFER_TYPE_STRING, true)
				else 
					net_server_send(socketID, CODE_SKILL_INFO, json_stringify({ index: undefined, key: i }), BUFFER_TYPE_STRING, true)
			}
		}
	}
	
	counter++
	
	function_call_COMMON(main_loop, 3, false)
}
function_call_COMMON(main_loop, 3, false)

global.lastPositions_sent = ds_map_create()

// Non-table Data
global.playerBoxes = ds_map_create() // Items
global.playerQuests = ds_map_create() // Quests
global.playerSkills = ds_map_create() // Skill Tree
global.playerSkillBoxes = ds_map_create() // Skill Boxes
global.playerPermanentEffectBoxes = ds_map_create() // Permanent Effect Boxes

global.locations = ds_map_create() // Locations
ds_map_add(global.locations, 1, new location("Castle of Tophra", 1, 850, 600))
ds_map_add(global.locations, 2, new location("Front of the Castle", 1, 4310, 2600))
ds_map_add(global.locations, 3, new location("Arena", 1, 13429, 2444))

// Inventory Data
global.bc_hor_COMMON = 5
global.bc_ver_COMMON = 5
global.pageCount_COMMON = 3
global.boxEmpty_COMMON = box_create_COMMON()

// Skill Tree Data
global.sc_hor_COMMON = 4
global.sc_ver_COMMON = 4
global.pageCount_skill_COMMON = 3
global.boxEmpty_skill_COMMON = { skill: undefined }

// Server Control Mode
global.drawEventEnabled = true
global.selectedPlayer = undefined
global.playerControlMode = false

define_skills_base_COMMON()

alarm[1] = room_speed/5

wheel_x = undefined
wheel_y = undefined