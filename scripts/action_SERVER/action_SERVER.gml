function action_SERVER(rewardCode, messageBoxes, ownerID, playerInstance, socketID_sender, owner_assetName) {
	switch (rewardCode) {
		case "{Rew1}":
			return { xx: 700, yy: 250, title: "#Rew1", text: "{Rew1} has been earned.", duration: 1, isDialogueMessage: false, ownerID: ownerID, owner: owner_assetName }
			
		case "{Rew2}":
			return { xx: 700, yy: 250, title: "#Rew2", text: "{Rew2} has been earned.", duration: 1, isDialogueMessage: false, ownerID: ownerID, owner: owner_assetName }
			
		case "{Trade-Weapon}":		
			with (objNPC_SERVER)
				if (asset_get_index(owner_assetName) == objWeaponSeller) {
					net_server_send(socketID_sender, CODE_WINDOW, json_stringify({ json: json_write_boxes_SERVER(socketID_sender, boxes), window: object_get_name(objTrade_window), owner: ownerID }), BUFFER_TYPE_STRING)
					break
				}
			break
	}
	
	return undefined
}