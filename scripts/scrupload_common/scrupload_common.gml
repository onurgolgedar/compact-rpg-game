function upload_COMMON (clientID, clientPassword, fromServer = false, socketID = -1) {
	var accountinfo = db_get_row(global.DB_SRV_TABLE_accountinfo, clientID)
	
	// Upload the account
	ini_open("Boxes.dbfile")
		var _str_items = ini_read_string("Items", clientID, "")
		if (_str_items == "")
			_str_items = undefined
							
		var _str_skills = ini_read_string("Skills", clientID, "")
		if (_str_skills == "")
			_str_skills = undefined
							
		var _str_skillBoxes = ini_read_string("SkillBoxes", clientID, "")
		if (_str_skillBoxes == "")
			_str_skillBoxes = undefined
								
		var _str_permanentEffectBoxes = ini_read_string("PermanentEffectBoxes", clientID, "")
		if (_str_permanentEffectBoxes == "")
			_str_permanentEffectBoxes = undefined
	ini_close()
					
	ini_open("Quests.dbfile")
		var _str_quests = ini_read_string("Quests", clientID, "")
		if (_str_quests == "")
			_str_quests = undefined
	ini_close()
				
	if (fromServer)
		net_server_send(socketID, _CODE_UPLOAD, json_stringify({ accountID: clientID, password: clientPassword, items: _str_items, skills: _str_skills, permanentEffectBoxes: _str_permanentEffectBoxes, quests: _str_quests, gold: accountinfo[? ACCOUNTINFO_GOLD_SERVER], level: accountinfo[? ACCOUNTINFO_LEVEL_SERVER], skillPoints: accountinfo[? ACCOUNTINFO_SKILLPOINTS_SERVER], skillBoxes: _str_skillBoxes, autoLogin: false }), BUFFER_TYPE_STRING)
	else
		net_client_send(_CODE_UPLOAD, json_stringify({ accountID: clientID, password: clientPassword, items: _str_items, skills: _str_skills, permanentEffectBoxes: _str_permanentEffectBoxes, quests: _str_quests, gold: accountinfo[? ACCOUNTINFO_GOLD_SERVER], level: accountinfo[? ACCOUNTINFO_LEVEL_SERVER], skillPoints: accountinfo[? ACCOUNTINFO_SKILLPOINTS_SERVER], skillBoxes: _str_skillBoxes, autoLogin: false }), BUFFER_TYPE_STRING)
}