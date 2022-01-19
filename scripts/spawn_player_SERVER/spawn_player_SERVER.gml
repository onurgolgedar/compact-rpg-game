function spawn_player_SERVER(socketID) {
	with (objPlayer)
		if (id.socketID == socketID)
			instance_destroy()
			
	var accountID = db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_ACCID_SERVER, ONLINEACCOUNTS_SOCKETID_SERVER, socketID)
	var accountInfoRow = db_get_row(global.DB_SRV_TABLE_accountInfo, accountID)
	
	var location = ds_map_find_value(global.locations, accountInfoRow[? ACCOUNTINFO_LOCATION_SERVER])
	var xx = location.spawn_x
	var yy = location.spawn_y
	
	var newPlayer = instance_create_depth(xx, yy, 0, objPlayer_SERVER)
	newPlayer.socketID = socketID
	newPlayer.playerRow = db_get_row(global.DB_SRV_TABLE_players, socketID)
	newPlayer.accountID = accountID
	
	var accountRow = db_get_row(global.DB_SRV_TABLE_accounts, db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_ACCID_SERVER, ONLINEACCOUNTS_SOCKETID_SERVER, socketID))
	newPlayer.name = accountRow[? ACCOUNTS_NICKNAME_SERVER]
	newPlayer.class = accountRow[? ACCOUNTS_CLASS_SERVER]
	
	newPlayer.level = accountInfoRow[? ACCOUNTINFO_LEVEL_SERVER]
	
	with (newPlayer) {
		targetID = socketID
		
		recalculate_character_statistics_SERVER()
		
		var playerSkillBoxes = global.playerSkillBoxes[? accountID]
		if (playerSkillBoxes != undefined) {
			for (var i = 0; i < 5; i++) {
				if (playerSkillBoxes[? i] != undefined) {
					ds_map_set(skills, i,
					{
						index: playerSkillBoxes[? i].index,
						cooldownmax: playerSkillBoxes[? i].cooldownmax,
						cooldown: playerSkillBoxes[? i].cooldown,
						code: playerSkillBoxes[? i].code,
						object: playerSkillBoxes[? i].object,
						casttimemax: playerSkillBoxes[? i].casttimemax,
						casttime: playerSkillBoxes[? i].casttime,
						mana: playerSkillBoxes[? i].mana,
						energy: playerSkillBoxes[? i].energy
					})
				}
			}
		}
		
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
					+"|"+string(newPlayer.mana)+"|"+string(newPlayer.class)+"|"+string(newPlayer.movementSpeed)+"|"+string(newPlayer.physicalPower)
					+"|"+string(newPlayer.magicalPower)+"|"+string(newPlayer.attackSpeed)+"|"+string(newPlayer.level), BUFFER_TYPE_STRING)
					
	send_appearence_to_all_SERVER(socketID, SOCKET_ID_ALL)
	
	return newPlayer
}