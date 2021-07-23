function spawn_player(socketID) {
	with (objPlayer)
		if (id.socketID == socketID)
			instance_destroy()
	
	var newPlayer = instance_create_depth(3960, 2162, 0, objPlayer_SERVER)
	newPlayer.socketID = socketID
	newPlayer.playerRow = db_get_row(global.DB_SRV_TABLE_players, socketID)
	newPlayer.accountID = db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_ACCID_SERVER, ONLINEACCOUNTS_SOCKETID_SERVER, socketID)
	
	var accountRow = db_get_row(global.DB_SRV_TABLE_accounts, db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_ACCID_SERVER, ONLINEACCOUNTS_SOCKETID_SERVER, socketID))
	newPlayer.name = accountRow[? ACCOUNTS_NICKNAME_SERVER]
	newPlayer.class = accountRow[? ACCOUNTS_CLASS_SERVER]
	
	with (newPlayer) {
		targetID = socketID
		
		recalculate_character_statistics_SERVER()
		
		var skill_index
		skill_index = SKILL_0
		ds_map_add(skills, 0,
		{
			index: skill_index,
			cooldownmax: global.skill_cooldown_max[skill_index],
			cooldown: 0,
			code: global.skill_code[skill_index],
			object: global.skill_object[skill_index],
			casttimemax: global.skill_casttime_max[skill_index],
			casttime: undefined,
			mana: global.skill_mana[skill_index],
			energy: global.skill_energy[skill_index]
		})
		
		skill_index = SKILL_1
		ds_map_add(skills, 1,
		{
			index: skill_index,
			cooldownmax: global.skill_cooldown_max[skill_index],
			cooldown: 0,
			code: global.skill_code[skill_index],
			object: global.skill_object[skill_index],
			casttimemax: global.skill_casttime_max[skill_index],
			casttime: undefined,
			mana: global.skill_mana[skill_index],
			energy: global.skill_energy[skill_index]
		})
		
		skill_index = SKILL_2
		ds_map_add(skills, 2,
		{
			index: skill_index,
			cooldownmax: global.skill_cooldown_max[skill_index],
			cooldown: 0,
			code: global.skill_code[skill_index],
			object: global.skill_object[skill_index],
			casttimemax: global.skill_casttime_max[skill_index],
			casttime: undefined,
			mana: global.skill_mana[skill_index],
			energy: global.skill_energy[skill_index]
		})
		
		skill_index = SKILL_3
		ds_map_add(skills, 3,
		{
			index: skill_index,
			cooldownmax: global.skill_cooldown_max[skill_index],
			cooldown: 0,
			code: global.skill_code[skill_index],
			object: global.skill_object[skill_index],
			casttimemax: global.skill_casttime_max[skill_index],
			casttime: undefined,
			mana: global.skill_mana[skill_index],
			energy: global.skill_energy[skill_index]
		})
		
		hp = maxHp
		energy = maxEnergy
		mana = maxMana
	}
	
	newPlayer.playerRow[? PLAYERS_INSTANCE_SERVER] = newPlayer
	newPlayer.playerRow[? PLAYERS_X_SERVER] = newPlayer.x
	newPlayer.playerRow[? PLAYERS_Y_SERVER] = newPlayer.y
	newPlayer.playerRow[? PLAYERS_HP_SERVER] = newPlayer.hp
	newPlayer.playerRow[? PLAYERS_MANA_SERVER] = newPlayer.mana
	newPlayer.playerRow[? PLAYERS_ENERGY_SERVER] = newPlayer.energy
	newPlayer.playerRow[? PLAYERS_ANGLE_SERVER] = newPlayer.image_angle
	newPlayer.playerRow[? PLAYERS_DEATHTIMER_SERVER] = 0
	
	net_server_send(SOCKET_ID_ALL, CODE_SPAWN_PLAYER, string(socketID)+"|"+string(newPlayer.x)+"|"+string(newPlayer.y)+"|"+string(newPlayer.maxHp)+"|"+string(newPlayer.maxEnergy)
					+"|"+string(newPlayer.mana)+"|"+string(newPlayer.class), BUFFER_TYPE_STRING)
					
	send_appearence_to_all_SERVER(socketID, SOCKET_ID_ALL)
	
	return newPlayer
}