function dialogue_set_values_SERVER(text, playerInstance) {
	if (playerInstance == undefined or instance_exists(playerInstance)) {
		var result = text
		var value = undefined
		
		// List of changes
		value = playerInstance != undefined ? global.playerNames[? playerInstance.socketID] : undefined
		if (value == undefined)
			value = ""
		result = string_replace_all(text, "{name}", value)
		
		return result
	}
	else
		return text
}

function dialogue_progress_SERVER(messageID, dialogueNo, owner_assetName, ownerID = undefined, answerBefore = -1, socketID_sender = undefined) {
	var messageBoxes = [undefined, undefined]

	var text = ""
	var title = ""
	var dialogueSize = 0
	var ans = ["Okay", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
	var npcName = npc_get_name_COMMON(asset_get_index(owner_assetName))
	
	var playerInstance = undefined
	if (socketID_sender != undefined) {
		playerInstance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
		if (playerInstance == undefined or !instance_exists(playerInstance))
			return messageBoxes
	}

	ini_open("dialogues.ini")
		text = dialogue_set_values_SERVER(ini_read_string(npcName, string(messageID)+"."+string(dialogueNo), "undefined"), playerInstance)
		title = ini_read_string(npcName, string(messageID)+",T", "undefined")
				
		var actionCode = "undefined"
		var actionText = "undefined"
		var actionRedirect = -1
			
		if (answerBefore != -1) {
			actionCode = ini_read_string(npcName, string(messageID)+"."+string(dialogueNo-1)+",BA"+string(answerBefore+1)+"R", "undefined")
			actionText =  dialogue_set_values_SERVER(ini_read_string(npcName, string(messageID)+"."+string(dialogueNo-1)+",BA"+string(answerBefore+1), "undefined"), playerInstance)
			actionRedirect =  ini_read_real(npcName, string(messageID)+"."+string(dialogueNo-1)+",BR"+string(answerBefore+1), -1)
			if (actionRedirect != -1 and socketID_sender != undefined)
				_net_receive_packet(_CODE_DIALOGUE, json_stringify({ owner_assetName: owner_assetName, ownerID: ownerID, messageID: string(actionRedirect), dialogueNo: 1, answerBefore: -1}), socketID_sender)
		}		
			
		if (actionCode != "undefined") {
			var additional_actionMessageBox = action_SERVER(actionCode, messageBoxes, playerInstance, socketID_sender, owner_assetName, ownerID)
			if (additional_actionMessageBox != undefined)
				messageBoxes[0] = additional_actionMessageBox
		}
			
		if (actionText != "undefined") {
			messageBoxes[1] = new st_dialoguebox(500, 250, title, actionText, owner_assetName, ownerID, messageID, 5)
			return messageBoxes
		}
		else if (actionRedirect == -1 and text != "undefined") {
			while (ini_read_string(npcName, string(messageID)+"."+string(++dialogueSize), "undefined") != "undefined")
				continue
			dialogueSize--
			
			var mainKey_ini = string(messageID)+"."+string(dialogueNo)
			ans = [ ini_read_string(npcName, mainKey_ini+",B1", ""),
					ini_read_string(npcName, mainKey_ini+",B2", ""),
					ini_read_string(npcName, mainKey_ini+",B3", ""),
					ini_read_string(npcName, mainKey_ini+",B4", ""),
					ini_read_string(npcName, mainKey_ini+",B5", ""),
					ini_read_string(npcName, mainKey_ini+",B6", ""),
					ini_read_string(npcName, mainKey_ini+",B7", ""),
					ini_read_string(npcName, mainKey_ini+",B8", ""),
					ini_read_string(npcName, mainKey_ini+",B9", ""),
					ini_read_string(npcName, mainKey_ini+",B10", ""),
					ini_read_string(npcName, mainKey_ini+",B11", ""),
					ini_read_string(npcName, mainKey_ini+",B12", ""),
					ini_read_string(npcName, mainKey_ini+",B13", ""),
					ini_read_string(npcName, mainKey_ini+",B14", ""),
					ini_read_string(npcName, mainKey_ini+",B15", ""),
					ini_read_string(npcName, mainKey_ini+",B16", "") ]
		}
	ini_close()
	
	if (actionRedirect == -1 and text != "undefined") {
		var qKey = dialogue_get_qKey_COMMON(messageID, dialogueNo)
		if (text != "") {
			var buttonsArray = [ new st_dialogueButton(ans[0]), new st_dialogueButton(ans[1]),
								 new st_dialogueButton(ans[2]), new st_dialogueButton(ans[3]),
								 new st_dialogueButton(ans[4]), new st_dialogueButton(ans[5]),
								 new st_dialogueButton(ans[6]), new st_dialogueButton(ans[7]) ]
			messageBoxes[1] = new st_dialoguebox(250, 250, title, text, owner_assetName, ownerID, messageID, 5, true, dialogueNo, dialogueSize, qKey, buttonsArray)
		}
	}
		
	return messageBoxes
}