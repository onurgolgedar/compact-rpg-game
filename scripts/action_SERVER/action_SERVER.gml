function action_SERVER(rewardCode, messageBoxes, playerInstance, socketID_sender, owner_assetName, ownerID = undefined) {
	switch (rewardCode) {
		case "{Rew1}":
			return new st_dialoguebox(700, 250, "#Rew1", "{Rew1} has been earned.", owner_assetName, ownerID)
			
			
		case "{Rew2}":
			return new st_dialoguebox(700, 250, "#Rew2", "{Rew2} has been earned.", owner_assetName, ownerID)
			
		case "{Trade-Weapon}":		
			with (objNPC_SERVER)
				if (asset_get_index(owner_assetName) == objWeaponSeller) {
					net_server_send(socketID_sender, CODE_WINDOW, json_stringify({ json: json_write_boxes_SERVER(socketID_sender, boxes), window: object_get_name(objTrade_window), ownerID: ownerID }), BUFFER_TYPE_STRING)
					break
				}
			break
	}
	
	return undefined
}