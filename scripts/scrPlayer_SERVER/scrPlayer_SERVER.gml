function player_recalculate_statistics_SERVER() {
	maxHp = 50
	maxMana = 100
	maxEnergy = 100
	movementSpeed_base = 200
	physicalPower = 0
	magicalPower = 10
	attackSpeed = 0
	
	maxHp += (class == CLASS_WARRIOR_SERVER)*40
	maxMana += (class == CLASS_MAGE_SERVER)*40
	maxEnergy += 0
	movementSpeed_base += -(class == CLASS_MAGE)*20+(class == CLASS_ASSASSIN_SERVER)*35
	physicalPower += (class == CLASS_WARRIOR_SERVER)*9
	attackSpeed += (class == CLASS_WARRIOR_SERVER)*0.25+(class == CLASS_ASSASSIN_SERVER)*0.5
	magicalPower += (class == CLASS_MAGE_SERVER)*10
	
	var weaponBox = box_get_active_SERVER(socketID, ITEMTYPE_SWORD)
	if (weaponBox != undefined && weaponBox.item != undefined) {
		item_setup_COMMON(weaponBox.item)
		
		physicalPower += weaponBox.item.physicalPower
		magicalPower += weaponBox.item.magicalPower
		attackSpeed += weaponBox.item.attackSpeed
	}
	
	var clothesBox = box_get_active_SERVER(socketID, ITEMTYPE_CLOTHES)
	if (clothesBox != undefined && clothesBox.item != undefined) {
		item_setup_COMMON(clothesBox.item)
		
		maxHp += clothesBox.item.maxHp
		maxMana += clothesBox.item.maxMana
		movementSpeed_base = round(movementSpeed_base*(100-clothesBox.item.slowRate)/100)
	}
	
	hp = min(hp, maxHp)
	mana = min(mana, maxMana)
	movementSpeed = movementSpeed_base+movementSpeed_add
	
	net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_MAXHP, string(socketID)+"|"+string(maxHp), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_MAXMANA, string(socketID)+"|"+string(maxMana), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_PLAYER_ENERGY, string(socketID)+"|"+string(maxEnergy), BUFFER_TYPE_STRING, true)
}

function player_spawn_SERVER(socketID) {
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
	newPlayer.accountID = accountID
	newPlayer.playerRow = db_get_row(global.DB_SRV_TABLE_players, socketID)
	newPlayer.accountInfoRow = db_get_row(global.DB_SRV_TABLE_accountInfo, accountID)
	
	var accountRow = db_get_row(global.DB_SRV_TABLE_accounts, db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_ACCID_SERVER, ONLINEACCOUNTS_SOCKETID_SERVER, socketID))
	newPlayer.name = accountRow[? ACCOUNTS_NICKNAME_SERVER]
	newPlayer.class = accountRow[? ACCOUNTS_CLASS_SERVER]
	
	newPlayer.level = accountInfoRow[? ACCOUNTINFO_LEVEL_SERVER]
	
	with (newPlayer) {
		targetID = socketID
		
		player_recalculate_statistics_SERVER()
		
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
					
	tell_appearence_SERVER(socketID, SOCKET_ID_ALL)
	
	return newPlayer
}