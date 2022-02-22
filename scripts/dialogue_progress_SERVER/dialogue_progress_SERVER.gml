function dialogue_progress_SERVER(messageID, dialogueNo, owner_assetName, ownerID, answerBefore = -1, playerInstance = undefined, socketID_sender = undefined) {
	var messageBoxes = [undefined, undefined]

	var text = ""
	var title = ""
	var dialogueSize = 0
	var ans = ["Okay", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]
	var npcName = npc_get_name_COMMON(owner_assetName)

	ini_open("dialogues.ini")
		text = dialogue_set_values_SERVER(ini_read_string(npcName, string(messageID)+"."+string(dialogueNo), "undefined"), playerInstance)
		title = ini_read_string(npcName, string(messageID)+",T", "undefined")
				
		var rewardCode = "undefined"
		var rewardText = "undefined"
		var rewardRedirect = -1
			
		if (answerBefore != -1) {
			rewardCode = ini_read_string(npcName, string(messageID)+"."+string(dialogueNo-1)+",BA"+string(answerBefore+1)+"R", "undefined")
			rewardText =  dialogue_set_values_SERVER(ini_read_string(npcName, string(messageID)+"."+string(dialogueNo-1)+",BA"+string(answerBefore+1), "undefined"), playerInstance)
			rewardRedirect =  ini_read_real(npcName, string(messageID)+"."+string(dialogueNo-1)+",BR"+string(answerBefore+1), -1)
			if (rewardRedirect != -1 and socketID_sender != undefined)
				_net_receive_packet(_CODE_DIALOGUE, object_get_name(owner_assetName)+"|"+string(rewardRedirect)+"|1|-1|"+string(ownerID), socketID_sender, owner_assetName)
		}		
			
		if (rewardCode != "undefined") {
			var additional_rewardMessageBox = reward_give_SERVER(rewardCode, messageBoxes, ownerID, playerInstance, socketID_sender, object_get_name(owner_assetName))
			if (additional_rewardMessageBox != undefined)
				messageBoxes[0] = additional_rewardMessageBox
		}
			
		if (rewardText != "undefined") {
			messageBoxes[1] = { xx: 500, yy: 250, title: title, text: rewardText, ownerID: undefined, owner: undefined, duration: 5, isDialogueMessage: false, ownerID: ownerID, owner: owner_assetName }
			return messageBoxes
		}
		else if (rewardRedirect == -1 and text != "undefined") {
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
	
	if (rewardRedirect == -1 and text != "undefined") {
		var qKey = dialogue_get_qKey_COMMON(messageID, dialogueNo)
		if (text != "") {
			var buttonsArray = [ new dButton(ans[0]), new dButton(ans[1]),
								 new dButton(ans[2]), new dButton(ans[3]),
								 new dButton(ans[4]), new dButton(ans[5]),
								 new dButton(ans[6]), new dButton(ans[7]) ]
			messageBoxes[1] = { xx: 250, yy: 250, title: title, text: text, qKey: qKey, buttonsArray: buttonsArray, messageID: messageID, dialogueNo: dialogueNo, dialogueSize: dialogueSize, isDialogueMessage: true, ownerID: ownerID, owner: owner_assetName }
		}
	}
		
	return messageBoxes
}

function reward_give_SERVER(rewardCode, messageBoxes, ownerID, playerInstance, socketID_sender, owner_assetName) {
	switch (rewardCode) {
		case "{Rew1}":
			return { xx: 700, yy: 250, title: "#Rew1", text: "{Rew1} has been earned.", duration: 1, isDialogueMessage: false, ownerID: undefined, owner: undefined, ownerID: ownerID, owner: owner_assetName }
			
		case "{Rew2}":
			return { xx: 700, yy: 250, title: "#Rew2", text: "{Rew2} has been earned.", duration: 1, isDialogueMessage: false, ownerID: undefined, owner: undefined, ownerID: ownerID, owner: owner_assetName }
			
		case "{Trade-Weapon}":		
			with (objNPC_SERVER)
				if (asset_get_index(owner_assetName) == objWeaponSeller) {
					net_server_send(socketID_sender, CODE_WINDOW, json_stringify({ data: box_get_boxes_string_SERVER(socketID_sender, boxes), window: object_get_name(objTrade_window), owner: ownerID }), BUFFER_TYPE_STRING)
					break
				}
			break
	}
	
	return undefined
}

function dialogue_set_values_SERVER(text, playerInstance) {
	if (playerInstance == undefined or instance_exists(playerInstance)) {
		var result = text
		
		// List of changes
		result = string_replace_all(text, "{name}", playerInstance != undefined ? global.playerNames[? playerInstance.socketID] : "")
		
		return result
	}
	else
		return text
}