function recalculate_character_statistics_SERVER() {
	maxHp = 100
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
	
	var weaponBox = get_active_box_SERVER(socketID, ITEMTYPE_SWORD)
	if (weaponBox != undefined && weaponBox.item != undefined) {
		item_setup_COMMON(weaponBox.item)
		
		physicalPower += weaponBox.item.physicalPower
		magicalPower += weaponBox.item.magicalPower
		attackSpeed += weaponBox.item.attackSpeed
	}
	
	var clothesBox = get_active_box_SERVER(socketID, ITEMTYPE_CLOTHES)
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