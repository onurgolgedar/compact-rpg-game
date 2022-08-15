main_loop_counter = 0
function main_loop() {
	// Death Time Controller
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
				if (sid == global.socketID_player and (!global.drawEventEnabled_SERVER or global.drawServer_SERVER))
					_row[? PLAYERS_DEATHTIMER_SERVER] = 1
				else
					player_spawn_SERVER(sid)
			}
		}
	}

	with (objPlayer_SERVER) {
		tell_all_pl_positions_SERVER(id)
		
		if (other.main_loop_counter % 2 == 0) {
			tell_all_pl_healths_SERVER(id)
			tell_all_pl_manas_SERVER(id)
			tell_all_pl_energies_SERVER(id)
			tell_all_pl_angles_SERVER(id)
		}
			
		if (other.main_loop_counter % 3 == 0) {
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
	
	with (parNPC_SERVER) {
		if (other.main_loop_counter % 2 == 0)
			tell_all_npc_positions_SERVER(id)
			
		if (other.main_loop_counter % 3 == 0) {
			tell_all_npc_energies_SERVER(id)
			tell_all_npc_healths_SERVER(id)
			tell_all_npc_manas_SERVER(id)
			tell_all_npc_angles_SERVER(id)
		}
	}
	
	main_loop_counter++
	
	function_call_COMMON(main_loop, 3, false)
}
function_call_COMMON(main_loop, 3, false)

// Non-table Data
global.playerBoxes_SERVER = ds_map_create() // Items
global.playerQuests_SERVER = ds_map_create() // Quests
global.playerSkills_SERVER = ds_map_create() // Skill Tree
global.playerSkillBoxes_SERVER = ds_map_create() // Skill Boxes
global.playerPermanentEffectBoxes_SERVER = ds_map_create() // Permanent Effect Boxes

global.locations_SERVER = ds_map_create() // Locations
ds_map_add(global.locations_SERVER, 1, new st_location("Castle of Tophra", 1, 2250, 2000))
ds_map_add(global.locations_SERVER, 2, new st_location("Front of the Castle", 1, 4310, 2600))
ds_map_add(global.locations_SERVER, 3, new st_location("Arena", 1, 13429, 2444))

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
global.drawEventEnabled_SERVER = true
global.selectedPlayer_SERVER = undefined
global.playerControlMode_SERVER = false

define_skills_base_COMMON()
define_skills_base_SERVER()