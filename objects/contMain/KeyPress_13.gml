if (keyboard_check(vk_alt)) {
}
else
if (global.gameTime > 2 and room == roomGame) {
	switch (keyboard_string) {
		case "-save":
			net_client_send(_CODE_SAVE, 0, BUFFER_TYPE_BOOL)
			break
			
		case "-sync":
			net_client_send(_CODE_SAVE, 1, BUFFER_TYPE_BOOL)
			break
			
		case "-pull":
			net_client_send(_CODE_UPLOAD_REQUEST)
			break
			
		case "-heal":
			with (objPlayer_SERVER) {
				hp = maxHp
				mana = maxMana
				energy = maxEnergy
	
				db_set_row_value(global.DB_SRV_TABLE_players, socketID, PLAYERS_HP_SERVER, hp)
				db_set_row_value(global.DB_SRV_TABLE_players, socketID, PLAYERS_MANA_SERVER, mana)
				db_set_row_value(global.DB_SRV_TABLE_players, socketID, PLAYERS_ENERGY_SERVER, energy)
			}
			break
		
		default:
			if (global.chatActive and keyboard_string != "")
				net_client_send(_CODE_CHAT, json_stringify({ title: global.clientName, txt: keyboard_string }), BUFFER_TYPE_STRING)
			break
	}
	
	global.chatActive = !global.chatActive
	keyboard_string = ""
	io_clear()
}