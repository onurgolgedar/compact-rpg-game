function _net_receive_packet(code, pureData, socketID_sender) {
	if (global.playerControlMode and instance_exists(global.selectedPlayer)) {
		if (socketID_sender == global.socketID_player)
			socketID_sender = global.selectedPlayer.socketID
		else
			exit
	}
	
	var data
	#region PARSE PARAMETERS
	var parameterCount = 0
	if (is_string(pureData) and string_count("|", pureData) > 0) {
		parameterCount = string_count("|", pureData)
		var cut = 0
		var parameterIndex = 0
		for (var i = 2; i <= string_length(pureData)+1; i++) {
		
			if (i == string_length(pureData)+1 or string_char_at(pureData, i) == "|") {
				var parameter = string_copy(pureData, cut+1, i-cut-1)
				data[parameterIndex] = parameter

				cut = i
				parameterIndex++
			}
		}
	}
	else {
		parameterCount = 1
		data[0] = argument[1]
	}
	#endregion

	try {
		switch(code) {										
			case CODE_GET_INVENTORY:
				var loaded_data = json_parse(data[0])
			
				ds_grid_destroy(global.boxes)
				
				var boxes_SERVER = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
				ds_grid_read(boxes_SERVER, loaded_data.boxes)
				for (var i = 0; i < global.bc_hor_COMMON*global.pageCount_COMMON; i++) {
					for (var j = 0; j < global.bc_ver_COMMON+2; j++) {
						var _data = ds_grid_get(boxes_SERVER, i, j)
						
						var _box = json_parse(_data)
						if (_box.item == pointer_null)
							_box.item = undefined
							
						ds_grid_set(boxes_SERVER, i, j, _box)
					}
				}
				
				global.boxes = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
				for (var i = 0; i < global.bc_hor_COMMON*global.pageCount_COMMON; i++) {
					for (var j = 0; j < global.bc_ver_COMMON+2; j++) {
						var box = ds_grid_get(boxes_SERVER, i, j)
		
						ds_grid_set(global.boxes, i, j, box)
					}
				}
				ds_grid_destroy(boxes_SERVER)

				with (objInventory_window)
					inventory_refresh()
					
				global.gold = loaded_data.gold
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_GET_INVENTORY_SKILL:
				ds_grid_destroy(global.boxes_skill)
				
				var boxes_skill_SERVER = ds_grid_create(global.sc_hor_COMMON*global.pageCount_skill_COMMON, global.sc_ver_COMMON)
				ds_grid_read(boxes_skill_SERVER, data[0])
				for (var i = 0; i < global.sc_hor_COMMON*global.pageCount_skill_COMMON; i++) {
					for (var j = 0; j < global.sc_ver_COMMON; j++) {
						var _data = ds_grid_get(boxes_skill_SERVER, i, j)
						
						var _box = json_parse(_data) 
						if (_box.skill == pointer_null)
							_box.skill = undefined
							
						ds_grid_set(boxes_skill_SERVER, i, j, _box)
					}
				}
				
				global.boxes_skill = ds_grid_create(global.sc_hor_COMMON*global.pageCount_skill_COMMON, global.sc_ver_COMMON)
				for (var i = 0; i < global.sc_hor_COMMON*global.pageCount_skill_COMMON; i++) {
					for (var j = 0; j < global.sc_ver_COMMON; j++) {
						var box = ds_grid_get(boxes_skill_SERVER, i, j)
		
						ds_grid_set(global.boxes_skill, i, j, box)
					}
				}
				ds_grid_destroy(boxes_skill_SERVER)

				with (objSkills_window)
					refresh()
					
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_APPEARENCE:
				var player = global.playerInstances[? real(data[0])]
				
				if (player != undefined)
					with (player) {
						id.weaponSprite = asset_get_index(data[1])
						shoulders.sprite_index = asset_get_index(data[2])
						//hair = asset_get_index(data[3])
					}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_WINDOW:
				var loaded_data = json_parse(data[0])
			
				var trade_window = instance_create_layer(450, 140, "Windows", asset_get_index(loaded_data.window))
				trade_window.owner = loaded_data.owner
			
				var boxes = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
				ds_grid_read(boxes, loaded_data.data)
				for (var i = 0; i < global.bc_hor_COMMON*global.pageCount_COMMON; i++) {
					for (var j = 0; j < global.bc_ver_COMMON+2; j++) {
						var _data = ds_grid_get(boxes, i, j)
						
						var _box = json_parse(_data)
						if (_box.item == pointer_null)
							_box.item = undefined
							
						ds_grid_set(boxes, i, j, _box)
					}
				}
				
				for (var i = 0; i < global.bc_hor_COMMON*global.pageCount_COMMON; i++) {
					for (var j = 0; j < global.bc_ver_COMMON+2; j++) {
						var box = ds_grid_get(boxes, i, j)
		
						ds_grid_set(trade_window.boxes, i, j, box)
					}
				}
				ds_grid_destroy(boxes)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_GET_ACCOUNTINFO:
				global.gold = data[0]
			break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_CHANGE_ACTIVE_BOX:
				if (data[1] != "undefined")
					change_active_box(real(data[0]), real(data[1]), real(data[2]), data[3])
				else
					change_active_box(real(data[0]), undefined, undefined, data[3])
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_CHANGE_BOX_POSITION:
				change_box_position(real(data[0]), real(data[1]), real(data[2]), real(data[3]))
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_DROP_COIN:
				var coinCenter = instance_create_layer(real(data[1]), real(data[2]), "Floor", objCoinCenter)
				coinCenter.value = real(data[3])
				coinCenter.id_server = real(data[0])
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_COLLECT_COIN:
				var player = global.playerInstances[? real(data[0])]
				
				if (player != undefined) {
					// ?
					with (objCoinCenter) {
						if (id_server = real(data[1])) {
							collector = player
							
							var ds_size = ds_list_size(coins)
							for (var i = 0; i < ds_size; i++) {
								var coin = ds_list_find_value(coins, i)
								coin.moving = true
								coin.collector = player

								with (coin) {
									var pow = 120
									var dir = point_direction(x, y, player.x, player.y)
									ds_map_add(spds, irandom(999999), {xx: lengthdir_x(pow, dir), yy: lengthdir_y(pow, dir)})
								}
							}
							
							break
						}
					}
				}
				
				if (global.socketID_player == real(data[0]))
					global.gold = real(data[2])
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_EFFECT_LASER:
				var target = global.playerInstances[? real(data[0])]
				if (target == undefined)
					target = global.creatureInstances[? real(data[0])]
		
				if (target != undefined) {
					with (target) {
						var effect = instance_create_layer(x, y, "Top", objEffect_laser)
						effect.target = id
					}
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_KILL:
				var target = global.playerInstances[? real(data[0])]
				if (target == undefined)
					target = global.creatureInstances[? real(data[0])]
		
				if (target != undefined)
					instance_destroy(target)
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_BASIC_ATTACK:
				var player = global.playerInstances[? real(data[0])]
		
				if (player != undefined)
					with (player) {
						anim_start(animSwingASword, real(data[1]), id, animSwingASword_style)

						if (animSwingASword_style < 2)
							animSwingASword_style++
						else
							animSwingASword_style = 0
					}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_SKILL_INFO:
				with (objPlayer) {
					if (data[0] != "undefined") {
						var skill = skills[real(data[1])]
						skill.index = real(data[0])
						skill.code = real(data[5])
						skill.cooldown = real(data[6])
						skill.maxcooldown = real(data[2])
						skill.energy = real(data[3])
						skill.mana = real(data[4])
						skill.sprite = get_skill_sprite(real(data[0]))
					}
					else
						skills[real(data[1])] = { index: undefined, cooldown: undefined, mana: undefined, energy: undefined, sprite: sprNothingness, maxcooldown: undefined, code: undefined }
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_SLIDING_TEXT:
				var target = global.playerInstances[? real(data[0])]
				if (target == undefined)
					target = global.creatureInstances[? real(data[0])]
		
				if (target != undefined)
					with (target) {
						var _text = {xx: real(data[1]), yy: real(data[2]), text: data[3], life: real(data[4]), spd_x: real(data[5]), spd_y: real(data[6]), color: real(data[7]), size: real(data[8]), maxlife: real(data[4])}
						ds_list_add(texts, _text)
					}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
				
			case CODE_DIALOGUE:
				if (array_length(data) > 1) {
					var buttonsArray = undefined
					if (data[3] != "undefined") {
						buttonsArray = json_parse(data[3])
						for (var i = 0; i < array_length(buttonsArray); i++)
							buttonsArray[i].image = asset_get_index(buttonsArray[i].image)
					}
				
					if (data[4] == "undefined")
						data[4] = undefined
					if (data[2] == "undefined")
						data[2] = undefined
					if (data[5] == "undefined")
						data[5] = undefined
					
					show_questionbox(450, 550, data[0], data[1], data[4] != undefined ? asset_get_index(data[4]) : data[4], data[2] != undefined ? real(data[2]) : data[2], buttonsArray, data[5] != undefined ? real(data[5]) : data[5])
				}
				else {
					var messageBoxes = json_parse(data[0])
						
					for (var i = 0; i < 2; i++) {
						var messageBox = messageBoxes[i]
						
						if (messageBox != pointer_null and messageBox != undefined) {
							if (messageBox.isDialogueMessage) {
								var dialogueBox = messageBox
								var buttonsArray = dialogueBox.buttonsArray
								for (var i = 0; i < array_length(buttonsArray); i++)
									if (buttonsArray[i].image != pointer_null)
										buttonsArray[i].image = asset_get_index(buttonsArray[i].image)
									else
										buttonsArray[i].image = undefined
											
								var dialogueBox_object = show_questionbox(dialogueBox.xx, dialogueBox.yy, dialogueBox.title, dialogueBox.text, dialogueBox.owner, dialogueBox.messageID, buttonsArray)
								dialogueBox_object.dialogueNo = dialogueBox.dialogueNo
								dialogueBox_object.dialogueSize = dialogueBox.dialogueSize
							}
							else
								show_messagebox(messageBox.xx, messageBox.yy, messageBox.title, messageBox.text, messageBox.duration)
						}
					}
				}
				break
	
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_GET_STATISTICS:
				var target = global.playerInstances[? real(data[0])]
				if (target == undefined)
					break

				with (target) {
					maxHp = real(data[1])
					maxEnergy = real(data[2])
					maxMana = real(data[3])
					movementSpeed = real(data[4])
					physicalPower = real(data[5])
					magicalPower = real(data[6])
					attackSpeed = real(data[7])
				}
			break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_SKILL0:
				var player = global.playerInstances[? data[0]]
			
				if (player != undefined) {
					player.skill[0] = 0
				
					if (player.object_index == objPlayer) {
						for (var i = 0; i < 5; i++) {
							if (player.skills[i].index == SKILL_0) {
								player.skills[i].cooldown = player.skills[i].maxcooldown
								break
							}
						}
					}
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_SKILL1:
				var player = global.playerInstances[? real(data[0])]
				if (player != undefined) {
					with (player) {
						var arrow = instance_create_layer(real(data[1]), real(data[2]), "Top", objArrow)
						with (arrow) {
							image_angle = real(data[3])
							var pow = 1400
							arrow.spd = {xx: lengthdir_x(pow, image_angle), yy: lengthdir_y(pow, image_angle)}
							arrow.owner = player
						}
					
						if (player.object_index == objPlayer) {
							for (var i = 0; i < 5; i++) {
								if (player.skills[i].index == SKILL_1) {
									player.skills[i].cooldown = player.skills[i].maxcooldown
									break
								}
							}
						}
					}
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_SKILL2:
				var player = global.playerInstances[? real(data[0])]
				if (player != undefined) {
					with (player) {
						var laser = instance_create_layer(data[1], data[2], "Top", objSkill2)
						with (laser) {
							owner = player
							lock = data[5]
							image_blend = c_red
							image_angle = data[3]
							image_xscale = data[4]
						}
					
						if (player.object_index == objPlayer) {
							for (var i = 0; i < 5; i++) {
								if (player.skills[i].index == SKILL_2) {
									player.skills[i].cooldown = player.skills[i].maxcooldown
									break
								}
							}
						}
					}
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_SKILL3:
				var player = global.playerInstances[? real(data[0])]
				if (player != undefined) {
					if (player.object_index == objPlayer) {
						for (var i = 0; i < 5; i++) {
							if (player.skills[i].index == SKILL_3) {
								player.skills[i].cooldown = player.skills[i].maxcooldown
								break
							}
						}
					}
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_LOCATION:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
				
				var accountID = db_get_value_by_key(global.DB_SRV_TABLE_onlineAccounts, socketID_sender, ONLINEACCOUNTS_ACCID_SERVER)
				var locationID =  db_get_value_by_key(global.DB_SRV_TABLE_accountInfo, accountID, ACCOUNTINFO_LOCATION_SERVER) + (data[0] == 1 ? 1 : -1)
				
				var location = ds_map_find_value(global.locations, locationID)
				
				if (location != undefined) {
					var xx = location.spawn_x
					var yy = location.spawn_y
				
					with (instance) {
						x = xx
						y = yy
					}
				
					db_set_row_value(global.DB_SRV_TABLE_accountInfo, accountID, ACCOUNTINFO_LOCATION_SERVER, locationID)
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_SPAWN_PLAYER:
				var _socketID = real(data[0])
		
				var newPlayer = instance_create_layer(real(data[1]), real(data[2]), "Normal", _socketID == global.socketID_player ? objPlayer : objOtherPlayer)
				newPlayer.socketID = _socketID
				newPlayer.maxHp = real(data[3])
				newPlayer.maxEnergy = real(data[4])
				newPlayer.maxMana = real(data[5])
				newPlayer.class = data[6]
				newPlayer.movementSpeed = real(data[7])
				newPlayer.physicalPower = real(data[8])
				newPlayer.magicalPower = real(data[9])
				newPlayer.attackSpeed = real(data[10])
				newPlayer.level = real(data[11])

				newPlayer.hp = newPlayer.maxHp
				newPlayer.energy = newPlayer.maxEnergy
				newPlayer.mana = newPlayer.maxMana
				newPlayer.rigidbody_set_definedstance(STANCE_NORMAL, 0.5)
				newPlayer.name = ds_map_find_value(global.playerNames, _socketID)
					
				if (newPlayer.object_index == objPlayer) {
					global.clientClass = newPlayer.class
					global.level = newPlayer.level
					global.clientName = newPlayer.name
				}
				
				switch (newPlayer.class) {
					case CLASS_WARRIOR:
						newPlayer.shoulders.sprite_index = sprClothes_000
						newPlayer.hair = sprHair_000
						break
						
					case CLASS_ASSASSIN:
						newPlayer.shoulders.sprite_index = sprClothes_000
						newPlayer.hair = sprHair_004
						break
						
					case CLASS_MAGE:
						newPlayer.shoulders.sprite_index = sprClothes_000
						newPlayer.hair = sprHair_002
						break
				}
				
				if (newPlayer.object_index == objPlayer and !global.drawServer) {
					camera_set_view_target(global.camera, objPlayer)
					camera_set_view_speed(global.camera, -1, -1)
				}
				
				ds_map_set(global.playerInstances, _socketID, newPlayer)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_SPAWN_NPC:
				var _npcID = real(data[0])
		
				var creature = instance_create_layer(real(data[1]), real(data[2]), "Normal", asset_get_index(data[7]))
				creature.npcID = _npcID
				creature.maxHp = real(data[3])
				creature.maxEnergy = real(data[4])
				creature.maxMana = real(data[5])

				creature.hp = creature.maxHp
				creature.energy = creature.maxEnergy
				creature.mana = creature.maxMana
				creature.rigidbody_set_definedstance(STANCE_NORMAL, 0.5)
				creature.name = data[6]
				
				ds_map_set(global.creatureInstances, _npcID, creature)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_GET_ACTIVE_QUESTS:
				ds_map_read(global.activeQuests_player, data[0])
				
				var keys = ds_map_keys_to_array(global.activeQuests_player)
				var ds_size = array_length(keys)
				for (var k = 0; k < ds_size; k++) {
					global.activeQuests_player[? keys[k]] = json_parse(global.activeQuests_player[? keys[k]])
							
					var quest = global.activeQuests_player[? keys[k]]
					if (quest.type == pointer_null)
						quest.type = undefined
					if (quest.targets == pointer_null)
						quest.targets = undefined
					if (quest.targetCounts == pointer_null)
						quest.targetCounts = undefined
					if (quest.requiredQuests == pointer_null)
						quest.requiredQuests = undefined
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_CONNECT:
				var _socketID = real(data[0])
				if (global.socketID_player == undefined)
					global.socketID_player = _socketID
					
				if (global.connectionGoal == 0)
					net_client_send(_CODE_SIGNUP, global.clientID_signup+"|"+global.clientPassword_signup+"|"+global.clientName_signup+"|"+global.clientClass_signup, BUFFER_TYPE_STRING)
				else {
					if (global.serverIP == "127.0.0.1")
						net_client_send(_CODE_LOGIN, global.clientID+"|"+global.clientPassword, BUFFER_TYPE_STRING)
					else {
						// Upload The Account To Remote Server
						ini_open("Boxes.dbfile")
							var _str_items = ini_read_string("Items", global.clientID, "")
							if (_str_items == "")
								_str_items = "undefined"
							
							var _str_skills = ini_read_string("Skills", global.clientID, "")
							if (_str_skills == "")
								_str_skills = "undefined"
							
							var _str_skillBoxes = ini_read_string("SkillBoxes", global.clientID, "")
							if (_str_skillBoxes == "")
								_str_skillBoxes = "undefined"
						ini_close()
					
						ini_open("Quests.dbfile")
							var _str_quests = ini_read_string("Quests", global.clientID, "")
							if (_str_quests == "")
								_str_quests = "undefined"
						ini_close()
						
						net_client_send(_CODE_UPLOAD, global.clientID+"|"+global.clientPassword+"|"+_str_items+"|"+_str_skills+"|"+_str_quests+"|"+string(global.gold)+"|"+string(global.level)+"|"+_str_skillBoxes, BUFFER_TYPE_STRING)
					}
				}
				break
		
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_DISCONNECT:
				var player = global.playerInstances[? real(data[0])]
				if (player != undefined)
					instance_destroy(player)
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_LOGIN_FAIL:
				room_goto(roomMenu)
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_PING:
				global.ping_udp = current_time-real(data[0])
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_LOGIN_SUCCESS:
				with (parPlayer)
					if (socketID == global.socketID_player)
						instance_destroy()
						
				global.clientClass = data[0]
		
				with (contClient)
					alarm[1] = -1
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
				
			/* // // // // // // // // // // // // // // // // // // // // // // // //
			--------------------------------------------------------------------------
			--------------------------------------------------------------------------
			--------------------------------------------------------------------------
			 SERVER-SIDE SERVER-SIDE SERVER-SIDE SERVER-SIDE SERVER-SIDE SERVER-SIDE
			--------------------------------------------------------------------------
			--------------------------------------------------------------------------
			--------------------------------------------------------------------------
			// // // // // // // // // // // // // // // // // // // // // // // // */
			
			case _CODE_SIGNUP:
				var onlineAccount = db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_SOCKETID_SERVER, ONLINEACCOUNTS_ACCID_SERVER, data[0])
				if (onlineAccount != undefined) {
					net_server_send(socketID_sender, CODE_LOGIN_FAIL)
					break
				}
				
				var account = db_get_row(global.DB_SRV_TABLE_accounts, data[0])
				if (account == undefined and data[1] != "" and data[2] != "") {
					account = db_create_row(data[0])
					account[? ACCOUNTS_PASSWORD_SERVER] = data[1]
					account[? ACCOUNTS_NICKNAME_SERVER] = data[2]
						
					if (data[3] == CLASS_WARRIOR or data[3] == CLASS_ASSASSIN or data[3] == CLASS_MAGE)
						account[? ACCOUNTS_CLASS_SERVER] = data[3]
					else
						account[? ACCOUNTS_CLASS_SERVER] = CLASS_WARRIOR
						
					db_add_row(global.DB_SRV_TABLE_accounts, account)
					db_save_table(global.DB_SRV_TABLE_accounts)
				}
				break
			
			case _CODE_LOGIN:
				var onlineAccount = db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_SOCKETID_SERVER, ONLINEACCOUNTS_ACCID_SERVER, data[0])
				if (onlineAccount != undefined) {
					net_server_send(socketID_sender, CODE_LOGIN_FAIL)
					break
				}

				var account = db_get_row(global.DB_SRV_TABLE_accounts, data[0])
				if (account != undefined and account[? ACCOUNTS_PASSWORD_SERVER] == data[1]) {
					if (account[? ACCOUNTS_PASSWORD_SERVER] == data[1]) {
					
						onlineAccount = db_create_row(socketID_sender)
						onlineAccount[? ONLINEACCOUNTS_ACCID_SERVER] = data[0]
						db_add_row(global.DB_SRV_TABLE_onlineAccounts, onlineAccount)
					}
					else {
						net_server_send(socketID_sender, CODE_LOGIN_FAIL)
						break
					}
				
					var row = db_create_row(socketID_sender)
					db_add_row(global.DB_SRV_TABLE_players, row)
					
					var accountInfoRow = db_get_row(global.DB_SRV_TABLE_accountInfo, onlineAccount[? ONLINEACCOUNTS_ACCID_SERVER])
					if (accountInfoRow == undefined) {
						accountInfoRow = db_create_row(data[0])
						accountInfoRow[? ACCOUNTINFO_GOLD_SERVER] = 500
						accountInfoRow[? ACCOUNTINFO_LEVEL_SERVER] = 1
						accountInfoRow[? ACCOUNTINFO_LOCATION_SERVER] = LOCATION_THE_CASTLE
						db_add_row(global.DB_SRV_TABLE_accountInfo, accountInfoRow)
					}
				
					var accountName = data[0]			
					ini_open("Boxes.dbfile")
						var _str_items = ini_read_string("Items", accountName, "")
						var _str_skills = ini_read_string("Skills", accountName, "")
						var _str_skillBoxes = ini_read_string("SkillBoxes", accountName, "")
					ini_close()
					
					ini_open("Quests.dbfile")
						var _str_quests = ini_read_string("Quests", accountName, "")
					ini_close()
					
					// Load Items
					if (global.playerBoxes[? accountName] == undefined) {
						if (_str_items != "") {
							var value = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
							ds_grid_read(value, _str_items)
						
							for (var k = 0; k < global.bc_hor_COMMON*global.pageCount_COMMON; k++)
								for (var z = 0; z < global.bc_ver_COMMON+2; z++) {
									var box = json_parse(ds_grid_get(value, k, z))
									ds_grid_set(value, k, z, box)
									if (box.item == pointer_null)
										box.item = undefined
									else
										box.item = get_item_COMMON(box.item.code)
								}
							
							ds_map_add(global.playerBoxes, accountName, value)
						}
						else {
							// Init Items
							var boxes_SERVER = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
							for (var t = 0; t < global.bc_hor_COMMON*global.pageCount_COMMON; t++)
								for (var z = 0; z < global.bc_ver_COMMON+2; z++)
									ds_grid_set(boxes_SERVER, t, z, box_create_COMMON())
	
							ds_grid_set(boxes_SERVER, 0, 0, {item: get_item_COMMON(SWORD_000), tag: {isActive: false, isForQuest: false}, count: 1})
							ds_grid_set(boxes_SERVER, 1, 0, {item: get_item_COMMON(SWORD_001), tag: {isActive: false, isForQuest: false}, count: 1})
							ds_grid_set(boxes_SERVER, 2, 0, {item: get_item_COMMON(SWORD_002), tag: {isActive: false, isForQuest: false}, count: 1})
							ds_grid_set(boxes_SERVER, 0, 1, {item: get_item_COMMON(SWORD_003), tag: {isActive: false, isForQuest: false}, count: 1})
							ds_grid_set(boxes_SERVER, 1, 1, {item: get_item_COMMON(CLOTHES_000), tag: {isActive: false, isForQuest: false}, count: 1})
							ds_grid_set(boxes_SERVER, 2, 1, {item: get_item_COMMON(CLOTHES_001), tag: {isActive: false, isForQuest: false}, count: 1})
							ds_grid_set(boxes_SERVER, 0, 2, {item: get_item_COMMON(CLOTHES_002), tag: {isActive: false, isForQuest: false}, count: 1})
							ds_grid_set(boxes_SERVER, 1, 2, {item: get_item_COMMON(CLOTHES_003), tag: {isActive: false, isForQuest: false}, count: 1})
						
							ds_map_add(global.playerBoxes, accountName, boxes_SERVER)
						}
					}
					
					// Load Quests
					if (global.playerQuests[? accountName] == undefined) {
						if (_str_quests != "") {
							var value = ds_map_create()
							ds_map_read(value, _str_quests)
						
							var keys = ds_map_keys_to_array(value)
							var ds_size = array_length(keys)
							for (var k = 0; k < ds_size; k++) {
								value[? keys[k]] = json_parse(value[? keys[k]])
							
								var quest = value[? keys[k]]
								if (quest.type == pointer_null)
									quest.type = undefined
								if (quest.targets == pointer_null)
									quest.targets = undefined
								if (quest.targetCounts == pointer_null)
									quest.targetCounts = undefined
								if (quest.requiredQuests == pointer_null)
									quest.requiredQuests = undefined
							}
							
							global.playerQuests[? accountName] = value
							
							quests_set(accountName)
						}
						else {
							// Init Quests
							global.playerQuests[? accountName] = ds_map_create()
						
							var _code = 0
							ds_map_add(global.playerQuests[? accountName], _code, { title: "Quest 1", isActive: false, isAvailable: false, code: _code, type: undefined, description: "That's an example quest. You can test it.\nBy the way, this is a new line.", isCompleted: false,
																					receivedFrom: undefined, targets: undefined, targetCounts: undefined, targetCounts_completed: undefined, isAuto: true,
																					isDeletable: false, isRepeatable: false, requiredQuests: undefined, requiredLevel: 1 })
						
							_code = 1
							ds_map_add(global.playerQuests[? accountName], _code, { title: "Quest 2", isActive: false, isAvailable: false, code: _code, type: undefined, description: "That's an example quest. You can test it.\nBy the way, this is a new line.", isCompleted: false,
																					receivedFrom: undefined, targets: undefined, targetCounts: undefined, targetCounts_completed: undefined, isAuto: true,
																					isDeletable: true, isRepeatable: false, requiredQuests: undefined, requiredLevel: undefined })
																					
							_code = 2
							ds_map_add(global.playerQuests[? accountName], _code, { title: "Quest 3", isActive: false, isAvailable: false, code: _code, type: undefined, description: "That's an example quest. You can test it.\nBy the way, this is a new line.", isCompleted: false,
																					receivedFrom: undefined, targets: undefined, targetCounts: undefined, targetCounts_completed: undefined, isAuto: true,
																					isDeletable: true, isRepeatable: false, requiredQuests: undefined, requiredLevel: undefined })
																					
							_code = 3
							ds_map_add(global.playerQuests[? accountName], _code, { title: "Quest 4", isActive: false, isAvailable: false, code: _code, type: undefined, description: "That's an example quest. You can test it.\nBy the way, this is a new line.", isCompleted: false,
																					receivedFrom: undefined, targets: undefined, targetCounts: undefined, targetCounts_completed: undefined, isAuto: true,
																					isDeletable: true, isRepeatable: false, requiredQuests: undefined, requiredLevel: undefined })
																					
							_code = 4
							ds_map_add(global.playerQuests[? accountName], _code, { title: "Quest 5", isActive: false, isAvailable: false, code: _code, type: undefined, description: "That's an example quest. You can test it.\nBy the way, this is a new line.", isCompleted: false,
																					receivedFrom: undefined, targets: undefined, targetCounts: undefined, targetCounts_completed: undefined, isAuto: true,
																					isDeletable: true, isRepeatable: false, requiredQuests: undefined, requiredLevel: undefined })
																					
							_code = 5
							ds_map_add(global.playerQuests[? accountName], _code, { title: "Quest 6", isActive: false, isAvailable: false, code: _code, type: undefined, description: "That's an example quest. You can test it.\nBy the way, this is a new line.", isCompleted: false,
																					receivedFrom: undefined, targets: undefined, targetCounts: undefined, targetCounts_completed: undefined, isAuto: true,
																					isDeletable: true, isRepeatable: false, requiredQuests: undefined, requiredLevel: undefined })
																					
							_code = 6
							ds_map_add(global.playerQuests[? accountName], _code, { title: "Quest 7", isActive: false, isAvailable: false, code: _code, type: undefined, description: "That's an example quest. You can test it.\nBy the way, this is a new line.", isCompleted: false,
																					receivedFrom: undefined, targets: undefined, targetCounts: undefined, targetCounts_completed: undefined, isAuto: true,
																					isDeletable: true, isRepeatable: false, requiredQuests: undefined, requiredLevel: undefined })
																					
							_code = 7
							ds_map_add(global.playerQuests[? accountName], _code, { title: "Quest 8", isActive: false, isAvailable: false, code: _code, type: undefined, description: "That's an example quest. You can test it.\nBy the way, this is a new line.", isCompleted: false,
																					receivedFrom: undefined, targets: undefined, targetCounts: undefined, targetCounts_completed: undefined, isAuto: true,
																					isDeletable: true, isRepeatable: false, requiredQuests: undefined, requiredLevel: undefined })
																					
							_code = 8
							ds_map_add(global.playerQuests[? accountName], _code, { title: "Quest 9", isActive: false, isAvailable: false, code: _code, type: undefined, description: "That's an example quest. You can test it.\nBy the way, this is a new line.", isCompleted: false,
																					receivedFrom: undefined, targets: undefined, targetCounts: undefined, targetCounts_completed: undefined, isAuto: true,
																					isDeletable: true, isRepeatable: false, requiredQuests: undefined, requiredLevel: undefined })
																					
							_code = 9
							ds_map_add(global.playerQuests[? accountName], _code, { title: "Quest 10", isActive: false, isAvailable: false, code: _code, type: undefined, description: "That's an example quest. You can test it.\nBy the way, this is a new line.", isCompleted: false,
																					receivedFrom: undefined, targets: undefined, targetCounts: undefined, targetCounts_completed: undefined, isAuto: true,
																					isDeletable: true, isRepeatable: false, requiredQuests: undefined, requiredLevel: undefined })
																					
							_code = 10
							ds_map_add(global.playerQuests[? accountName], _code, { title: "Quest 11", isActive: false, isAvailable: false, code: _code, type: undefined, description: "That's an example quest. You can test it.\nBy the way, this is a new line.", isCompleted: false,
																					receivedFrom: undefined, targets: undefined, targetCounts: undefined, targetCounts_completed: undefined, isAuto: true,
																					isDeletable: true, isRepeatable: false, requiredQuests: [[3]], requiredLevel: undefined })
																					
							quests_set(accountName)
						}
					}
					
					// Load Skill Boxes
					if (global.playerSkillBoxes[? accountName] == undefined) {
						if (_str_skillBoxes != "") {
							var value = ds_map_create()
							ds_map_read(value, _str_skillBoxes)
						
							var keys = ds_map_keys_to_array(value)
							var ds_size = array_length(keys)
							for (var k = 0; k < ds_size; k++) {
								value[? keys[k]] = json_parse(value[? keys[k]])
								if (value[? keys[k]] == pointer_null)
									value[? keys[k]] = undefined		
								else {
									if (value[? keys[k]].casttime == pointer_null)
									value[? keys[k]].casttime = undefined		
								}
							}
							
							global.playerSkillBoxes[? accountName] = value
						}
						else
							global.playerSkillBoxes[? accountName] = ds_map_create()
					}
					
					// Load Skill Tree
					if (global.playerSkills[? accountName] == undefined) {
						if (_str_skills != "") {
							var value = ds_grid_create(global.sc_hor_COMMON*global.pageCount_skill_COMMON, global.sc_ver_COMMON)
							ds_grid_read(value, _str_skills)
						
							for (var k = 0; k < global.sc_hor_COMMON*global.pageCount_skill_COMMON; k++)
								for (var z = 0; z < global.sc_ver_COMMON; z++) {
									var box = json_parse(ds_grid_get(value, k, z))
									ds_grid_set(value, k, z, box)
									if (box.skill == pointer_null)
										box.skill = undefined
									else
										box.skill = get_skill_COMMON(box.skill.index, box.skill.upgrade)
								}
							
							ds_map_add(global.playerSkills, accountName, value)
						}
						else {
							// Init Skill Tree
							var boxes_skill_SERVER = ds_grid_create(global.sc_hor_COMMON*global.pageCount_skill_COMMON, global.sc_ver_COMMON)
							for (var t = 0; t < global.sc_hor_COMMON*global.pageCount_skill_COMMON; t++)
								for (var z = 0; z < global.sc_ver_COMMON; z++)
									ds_grid_set(boxes_skill_SERVER, t, z, global.boxEmpty_skill_COMMON)
	
							ds_grid_set(boxes_skill_SERVER, 0, 0, {skill: get_skill_COMMON(SKILL_0, 0)})
							ds_grid_set(boxes_skill_SERVER, 4, 0, {skill: get_skill_COMMON(SKILL_1, 0)})
							ds_grid_set(boxes_skill_SERVER, 0, 1, {skill: get_skill_COMMON(SKILL_2, 0)})
							ds_grid_set(boxes_skill_SERVER, 4, 1, {skill: get_skill_COMMON(SKILL_3, 0)})
						
							ds_map_add(global.playerSkills, accountName, boxes_skill_SERVER)
						}
					}
				
					// Map Creation
					with (objRock_SERVER)
						net_server_send(socketID_sender, CODE_PLACE_OBSTACLES, string(round(x))+"|"+string(round(y))+"|"+string(image_xscale)+"|"+string(image_yscale)+"|"+string(round(image_angle)), BUFFER_TYPE_STRING)
			
					with (objLight_SERVER)
						net_server_send(socketID_sender, CODE_PLACE_LIGHTS, string(round(x))+"|"+string(round(y))+"|"+string(Light_Range)+"|"+string(Light_Intensity)+"|"+string(Light_Color)+"|"+string(Light_Shadow_Length), BUFFER_TYPE_STRING)
				
					with (objTree_SERVER)
						net_server_send(socketID_sender, CODE_PLACE_TREES, string(type)+"|"+string(round(x))+"|"+string(round(y))+"|"+string(image_angle)+"|"+string(image_xscale)+"|"+string(image_yscale), BUFFER_TYPE_STRING)
				
					with (objLake_SERVER)
						net_server_send(socketID_sender, CODE_PLACE_LAKES, "1|"+string(round(x))+"|"+string(round(y))+"|"+string(image_angle)+"|"+string(image_xscale)+"|"+string(image_yscale), BUFFER_TYPE_STRING)
				
					with (objLake2_SERVER)
						net_server_send(socketID_sender, CODE_PLACE_LAKES, "2|"+string(round(x))+"|"+string(round(y))+"|"+string(image_angle)+"|"+string(image_xscale)+"|"+string(image_yscale), BUFFER_TYPE_STRING)
				
					with (objPlayer_SERVER)
						if (id.socketID != socketID_sender) {
							net_server_send(socketID_sender, CODE_SPAWN_PLAYER, string(id.socketID)+"|"+string(x)+"|"+string(y)+"|"+string(maxHp)+"|"+string(maxEnergy)+"|"+string(maxMana)+"|"+string(class)+
																				"|"+string(movementSpeed)+"|"+string(physicalPower)+"|"+string(magicalPower)+"|"+string(attackSpeed)+"|"+string(level), BUFFER_TYPE_STRING)
							send_appearence_to_all_SERVER(id.socketID, socketID_sender)
						}
				
					with (objCreature1_SERVER)
						net_server_send(socketID_sender, CODE_SPAWN_NPC, string(targetID)+"|"+string(x)+"|"+string(y)+"|"+string(maxHp)+"|"+string(maxEnergy)+"|"+string(maxMana)+"|"+string(name)+"|"+object_get_name(clientObject), BUFFER_TYPE_STRING)
						
					with (objNPC_SERVER)
						net_server_send(socketID_sender, CODE_SPAWN_NPC, string(targetID)+"|"+string(x)+"|"+string(y)+"|"+string(maxHp)+"|"+string(maxEnergy)+"|"+string(maxMana)+"|"+string(name)+"|"+object_get_name(clientObject), BUFFER_TYPE_STRING)
	
					net_server_send(socketID_sender, CODE_LOGIN_SUCCESS, account[? ACCOUNTS_CLASS_SERVER], BUFFER_TYPE_STRING)
					
					// Spawn Player
					var instance = spawn_player_SERVER(socketID_sender)
					
					// Send Private Data
					net_server_send(socketID_sender, CODE_GET_INVENTORY, json_stringify({ boxes: get_boxes_grid_SERVER(socketID_sender), gold: accountInfoRow[? ACCOUNTINFO_GOLD_SERVER] }), BUFFER_TYPE_STRING)
					net_server_send(socketID_sender, CODE_GET_ACCOUNTINFO, accountInfoRow[? ACCOUNTINFO_GOLD_SERVER], BUFFER_TYPE_INT32)
				
					// Send Shared Data
					tell_all_names()
					tell_all_positions_SERVER(true)
				}
				else
					net_server_send(socketID_sender, CODE_LOGIN_FAIL)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_SET_SKILLBOX:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
					
				var onlineAccount = db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_ACCID_SERVER, ONLINEACCOUNTS_SOCKETID_SERVER, socketID_sender)
				if (onlineAccount == undefined)
					break
			
				with (instance) {
					var skill_index = real(data[1])
					
					var isCancelled = false
					var foundI = undefined
					for (var i = 0; i < 5; i++)
						if (skills[? i] != undefined and skills[? i].index == skill_index) {
							foundI = i
							if (skills[? i].casttime == undefined) {
								if (real(data[2]) != -1 and skills[? real(data[2])] != undefined and skills[? real(data[0])] != undefined) {
									var other_skill_index = skills[? real(data[0])].index
									ds_map_set(skills, real(data[2]),
									{
										index: other_skill_index,
										cooldownmax: global.skill_cooldown_max_COMMON[other_skill_index],
										cooldown: global.skill_cooldown_max_COMMON[other_skill_index],
										code: global.skill_code_COMMON[other_skill_index],
										object: global.skill_object_SERVER[other_skill_index],
										casttimemax: global.skill_casttime_max_COMMON[other_skill_index],
										casttime: undefined,
										mana: global.skill_mana_COMMON[other_skill_index],
										energy: global.skill_energy_COMMON[other_skill_index]
									})
									ds_map_set(global.playerSkillBoxes[? onlineAccount], real(data[2]),
									{
										index: skills[? real(data[2])].index,
										cooldownmax: skills[? real(data[2])].cooldownmax,
										cooldown: skills[? real(data[2])].cooldown,
										code: skills[? real(data[2])].code,
										object: skills[? real(data[2])].object,
										casttimemax: skills[? real(data[2])].casttimemax,
										casttime: skills[? real(data[2])].casttime,
										mana: skills[? real(data[2])].mana,
										energy: skills[? real(data[2])].energy
									})
								}
								else {
									skills[? i] = undefined
									ds_map_delete(global.playerSkillBoxes[? onlineAccount], i)
								}
							}
							else
								isCancelled = true
						}
						
					if (isCancelled)
						break
					
					if (data[0] != "undefined") {
						// ? Duplication
						ds_map_set(skills, real(data[0]),
						{
							index: skill_index,
							cooldownmax: global.skill_cooldown_max_COMMON[skill_index],
							cooldown: global.skill_cooldown_max_COMMON[skill_index],
							code: global.skill_code_COMMON[skill_index],
							object: global.skill_object_SERVER[skill_index],
							casttimemax: global.skill_casttime_max_COMMON[skill_index],
							casttime: undefined,
							mana: global.skill_mana_COMMON[skill_index],
							energy: global.skill_energy_COMMON[skill_index]
						})
						ds_map_set(global.playerSkillBoxes[? onlineAccount], real(data[0]),
						{
							index: skills[? real(data[0])].index,
							cooldownmax: skills[? real(data[0])].cooldownmax,
							cooldown: skills[? real(data[0])].cooldown,
							code: skills[? real(data[0])].code,
							object: skills[? real(data[0])].object,
							casttimemax: skills[? real(data[0])].casttimemax,
							casttime: skills[? real(data[0])].casttime,
							mana: skills[? real(data[0])].mana,
							energy: skills[? real(data[0])].energy
						})
					}
					else {
						skills[? foundI] = undefined
						ds_map_delete(global.playerSkillBoxes[? onlineAccount], foundI)
					}
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_UPLOAD:
				var accountRow = db_get_row(global.DB_SRV_TABLE_accounts, data[0])
				if (accountRow != undefined and accountRow[? ACCOUNTS_PASSWORD_SERVER] != data[1])
					break
					
				if (data[0] == "" or data[1] == "")
					break
					
				if (global.playerBoxes[? socketID_sender] != undefined)
					ds_grid_destroy(global.playerBoxes[? socketID_sender])
					
				if (global.playerSkills[? socketID_sender] != undefined)
					ds_grid_destroy(global.playerSkills[? socketID_sender])
					
				if (global.playerQuests[? socketID_sender] != undefined)
					ds_map_destroy(global.playerQuests[? socketID_sender])
					
				if (global.playerSkillBoxes[? socketID_sender] != undefined)
					ds_map_destroy(global.playerSkillBoxes[? socketID_sender])
				
				// Uploaded Items
				if (data[2] != "undefined") {
					var boxes_TAKEN = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
					ds_grid_read(boxes_TAKEN, data[2])
					
					for (var i = 0; i < global.bc_hor_COMMON*global.pageCount_COMMON; i++) {
						for (var j = 0; j < global.bc_ver_COMMON+2; j++) {
							var _data = ds_grid_get(boxes_TAKEN, i, j)
						
							var _box = json_parse(_data)
							if (_box.item == pointer_null)
								_box.item = undefined
							else
								_box.item = get_item_COMMON(_box.item.code)
							
							ds_grid_set(boxes_TAKEN, i, j, _box)
						}
					}
				
					global.playerBoxes[? data[0]] = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
					for (var i = 0; i < global.bc_hor_COMMON*global.pageCount_COMMON; i++) {
						for (var j = 0; j < global.bc_ver_COMMON+2; j++) {
							var box = ds_grid_get(boxes_TAKEN, i, j)
		
							ds_grid_set(global.playerBoxes[? data[0]], i, j, box)
						}
					}
					ds_grid_destroy(boxes_TAKEN)
				}
				
				// Uploaded Skill Tree
				if (data[3] != "undefined") {
					var boxes_TAKEN = ds_grid_create(global.sc_hor_COMMON*global.pageCount_COMMON, global.sc_ver_COMMON)
					ds_grid_read(boxes_TAKEN, data[3])
					for (var i = 0; i < global.sc_hor_COMMON*global.pageCount_COMMON; i++) {
						for (var j = 0; j < global.sc_ver_COMMON; j++) {
							var _data = ds_grid_get(boxes_TAKEN, i, j)
						
							var _box = json_parse(_data)
							if (_box.skill == pointer_null)
								_box.skill = undefined
							else
								_box.skill = get_skill_COMMON(_box.skill.index, _box.skill.upgrade)
							
							ds_grid_set(boxes_TAKEN, i, j, _box)
						}
					}
				
					global.playerSkills[? data[0]] = ds_grid_create(global.sc_hor_COMMON*global.pageCount_COMMON, global.sc_ver_COMMON)
					for (var i = 0; i < global.sc_hor_COMMON*global.pageCount_COMMON; i++) {
						for (var j = 0; j < global.sc_ver_COMMON; j++) {
							var box = ds_grid_get(boxes_TAKEN, i, j)
		
							ds_grid_set(global.playerSkills[? data[0]], i, j, box)
						}
					}
					ds_grid_destroy(boxes_TAKEN)
				}
				
				// Uploaded Quests
				if (data[4] != "undefined") {
					var quests_TAKEN = ds_map_create()
					ds_map_read(quests_TAKEN, data[4])
					
					var _quests_keys = ds_map_keys_to_array(quests_TAKEN)
					var ds_size = array_length(_quests_keys)
					for (var i = 0; i < ds_size; i++) {
						var key = _quests_keys[i]
						var _data = ds_map_find_value(quests_TAKEN, key)
						
						var _quest = json_parse(_data)
						if (_quest.type == pointer_null)
							_quest.type = undefined
						if (_quest.targets == pointer_null)
							_quest.targets = undefined
						if (_quest.targetCounts == pointer_null)
							_quest.targetCounts = undefined
						if (_quest.requiredQuests == pointer_null)
							_quest.requiredQuests = undefined
						
						ds_map_set(quests_TAKEN, key, _quest)
					}
				
					global.playerQuests[? data[0]] = ds_map_create()
					for (var i = 0; i < ds_size; i++) {
						var key = _quests_keys[i]
						var quest = ds_map_find_value(quests_TAKEN, key)
		
						ds_map_add(global.playerQuests[? data[0]], key, quest)
					}
					ds_map_destroy(quests_TAKEN)
				}
				
				// Uploaded Skill Boxes
				if (data[7] != "undefined") {
					var skillBoxes_TAKEN = ds_map_create()
					ds_map_read(skillBoxes_TAKEN, data[7])
					
					var _skillBoxes_keys = ds_map_keys_to_array(skillBoxes_TAKEN)
					var ds_size = array_length(_skillBoxes_keys)
					for (var i = 0; i < ds_size; i++) {
						var key = _skillBoxes_keys[i]
						var _data = ds_map_find_value(skillBoxes_TAKEN, key)
						
						var _skillBox = json_parse(_data)
						if (_skillBox == pointer_null)
							_skillBox = undefined	
						else {
							if (_skillBox.casttime == pointer_null)
								_skillBox.casttime = undefined
						}
						ds_map_set(skillBoxes_TAKEN, key, _skillBox)
					}
				
					global.playerSkillBoxes[? data[0]] = ds_map_create()
					for (var i = 0; i < ds_size; i++) {
						var key = _skillBoxes_keys[i]
						var skillBox = ds_map_find_value(skillBoxes_TAKEN, key)
		
						ds_map_add(global.playerSkillBoxes[? data[0]], key, skillBox)
					}
					ds_map_destroy(skillBoxes_TAKEN)
				}
				
				var accountInfoRow = db_get_row(global.DB_SRV_TABLE_accountInfo, data[0])
				if (accountInfoRow == undefined) {
					accountInfoRow = db_create_row(data[0])
					accountInfoRow[? ACCOUNTINFO_GOLD_SERVER] = real(data[5])
					accountInfoRow[? ACCOUNTINFO_LEVEL_SERVER] = real(data[6])
					db_add_row(global.DB_SRV_TABLE_accountInfo, accountInfoRow)
					db_save_table(global.DB_SRV_TABLE_accountInfo)
				}
				else
				{
					accountInfoRow[? ACCOUNTINFO_GOLD_SERVER] = real(data[5])
					accountInfoRow[? ACCOUNTINFO_LEVEL_SERVER] = real(data[6])
					db_save_table(global.DB_SRV_TABLE_accountInfo)
				}
				
				_net_receive_packet(_CODE_LOGIN, data[0]+"|"+data[1], socketID_sender)
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_KEYRELEASE:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				with (instance) {
					switch (data[0]) {
						case 1:
							key_w = false
							break
						
						case 2:
							key_a = false
							break
						
						case 3:
							key_s = false
							break
						
						case 4:
							key_d = false
							break
					}
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_BASIC_ATTACK:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				with (instance)
					if (attackSpeed_rem == 0 and energy > 15) {
						var dir = point_direction(x, y, data[0], data[1])
						image_angle = dir
					
						change_energy(-15)
	
						attackSpeed_rem = 1/attackSpeed
						attackTimer = attackSpeed_rem*0.6
						net_server_send(SOCKET_ID_ALL, CODE_BASIC_ATTACK, string(socketID_sender)+"|"+string(1/attackSpeed), BUFFER_TYPE_STRING)
					}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_SKILL0:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				var skill = cast_skill(0, instance)
				if (skill != undefined)
					net_server_send(SOCKET_ID_ALL, CODE_SKILL0, socketID_sender, BUFFER_TYPE_INT32)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_CHANGE_ACTIVE_BOX:
				var box
				if (data[1] != "undefined")
					box = change_active_box_SERVER(socketID_sender, real(data[0]), real(data[1]), real(data[2]), data[3])
				else
					box = change_active_box_SERVER(socketID_sender, real(data[0]), undefined, undefined, data[3])
					
				if (box != -1) {
					if (data[1] != "undefined")
						net_server_send(socketID_sender, CODE_CHANGE_ACTIVE_BOX, data[0]+"|"+data[1]+"|"+data[2]+"|"+data[3], BUFFER_TYPE_STRING)
					else
						net_server_send(socketID_sender, CODE_CHANGE_ACTIVE_BOX, data[0]+"|undefined|undefined|"+data[3], BUFFER_TYPE_STRING)
					
					var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
					if (instance == undefined or !instance_exists(instance))
						break
					
					var _box = get_active_box_SERVER(socketID_sender, ITEMTYPE_SWORD)
					var weaponSprite = _box.item == undefined ? sprite_get_name(sprNothingness) : sprite_get_name(_box.item.sprite)
	
					_box = get_active_box_SERVER(socketID_sender, ITEMTYPE_CLOTHES)
					var clothesSprite = _box.item == undefined ? sprite_get_name(sprNothingness) : sprite_get_name(_box.item.sprite)
					
					net_server_send(SOCKET_ID_ALL, CODE_APPEARENCE, string(socketID_sender)+"|"+weaponSprite+"|"+clothesSprite, BUFFER_TYPE_STRING)
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_BUY:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				with (parNPC_SERVER) {
					if (id.npcID == real(data[4])) {
						var box = ds_grid_get(id.boxes, real(data[1]), real(data[2]))
						
						if (box.item != undefined and box.item.type == real(data[0])) {
							item_setup_COMMON(box.item)
							if (get_box_confirmation_number_COMMON(box) == data[3]) {
								var price = 1//box.item.worth/10
								if (instance.accountInfoRow[? ACCOUNTINFO_GOLD_SERVER] >= price) {
									if (data[5] == "undefined" and add_item_SERVER(box.item, instance.accountInfoRow[? ACCOUNTINFO_ACCID_SERVER])
										or data[5] != "undefined" and add_item_SERVER(box.item, instance.accountInfoRow[? ACCOUNTINFO_ACCID_SERVER], real(data[5]), real(data[6]))) {
										instance.accountInfoRow[? ACCOUNTINFO_GOLD_SERVER] -= price
									
										net_server_send(socketID_sender, CODE_GET_INVENTORY, json_stringify({ boxes: get_boxes_grid_SERVER(socketID_sender), gold: instance.accountInfoRow[? ACCOUNTINFO_GOLD_SERVER] }), BUFFER_TYPE_STRING)
										net_server_send(socketID_sender, CODE_DIALOGUE, "Purchased: "+box.item.name+"|You have paid "+string(price)+" [img=sprCoin2].|undefined|undefined|undefined|1", BUFFER_TYPE_STRING)
									}
								}
							}
						}
						
						break
					}
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
	
			case _CODE_DIALOGUE:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				var title = "undefined"
				var text = "undefined"
				var buttons = "undefined"
			
				switch (asset_get_index(data[0])) {
					// contMain
					case contMain:
						switch (data[1]) {
							// Message -1
							case 1:
								title = "Message"
								text = "You are given a cup of coffee.\nHow much gold do you want to tip?"
								buttons = json_stringify([ new dButton("10", sprite_get_name(sprCoin), false, 10), new dButton("20", sprite_get_name(sprCoin), false, 20),
														   new dButton("30", sprite_get_name(sprCoin), false, 30), new dButton("40", sprite_get_name(sprCoin), false, 40),
														   new dButton("50", sprite_get_name(sprCoin), false, 50), new dButton("60", sprite_get_name(sprCoin), false, 60),
														   new dButton("70", sprite_get_name(sprCoin), false, 70), new dButton("80", sprite_get_name(sprCoin), false, 80),
														   new dButton("90", sprite_get_name(sprCoin), false, 90), new dButton("100", sprite_get_name(sprCoin), false, 100) ])
								break
								
							case 2:
								title = "Message 2"
								text = "You are given a cup of coffee.\nHow much gold do you want to tip?"
								buttons = json_stringify([ new dButton("10", sprite_get_name(sprCoin), false, 10), new dButton("20", sprite_get_name(sprCoin), false, 20),
														   new dButton("30", sprite_get_name(sprCoin), false, 30), new dButton("40", sprite_get_name(sprCoin), false, 40),
														   new dButton("50", sprite_get_name(sprCoin), false, 50), new dButton("60", sprite_get_name(sprCoin), false, 60),
														   new dButton("70", sprite_get_name(sprCoin), false, 70), new dButton("80", sprite_get_name(sprCoin), false, 80),
														   new dButton("90", sprite_get_name(sprCoin), false, 90), new dButton("100", sprite_get_name(sprCoin), false, 100) ])
								break
						}
						break
				}
				
				if (title != "undefined")
					net_server_send(socketID_sender, CODE_DIALOGUE, title+"|"+text+"|"+string(data[1])+"|"+buttons+"|"+data[0]+"|undefined", BUFFER_TYPE_STRING)
				else {
					var dialogueBox = dialogue_progress_SERVER(real(data[1]), real(data[2]), asset_get_index(data[0]), real(data[4]), real(data[3]), instance, socketID_sender)
					if (dialogueBox != undefined)
						net_server_send(socketID_sender, CODE_DIALOGUE, json_stringify(dialogueBox), BUFFER_TYPE_STRING)
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_GET_INVENTORY:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				net_server_send(socketID_sender, CODE_GET_INVENTORY, json_stringify({boxes: get_boxes_grid_SERVER(socketID_sender), gold: instance.accountInfoRow[? ACCOUNTINFO_GOLD_SERVER]}), BUFFER_TYPE_STRING)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_GET_INVENTORY_SKILL:
				net_server_send(socketID_sender, CODE_GET_INVENTORY_SKILL, get_boxes_skill_grid_SERVER(socketID_sender), BUFFER_TYPE_STRING)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_GET_STATISTICS:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				with (instance)
					net_server_send(socketID_sender, CODE_GET_STATISTICS, string(socketID_sender)+"|"+string(maxHp)+"|"+string(maxEnergy)+"|"+string(maxMana)+"|"+string(movementSpeed)+"|"+string(physicalPower)+"|"+string(magicalPower)+"|"+string(attackSpeed), BUFFER_TYPE_STRING)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_DROP_COIN:
				var coinCenter = instance_create(real(data[0]), real(data[1]), objCoinCenter_SERVER)
				coinCenter.value = 20
				net_server_send(SOCKET_ID_ALL, CODE_DROP_COIN, string(coinCenter)+"|"+string(coinCenter.x)+"|"+string(coinCenter.y)+"|"+string(coinCenter.value), BUFFER_TYPE_STRING)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_CHANGE_BOX_POSITION:
				if (change_box_position_SERVER(socketID_sender, real(data[0]), real(data[1]), real(data[2]), real(data[3]))) {
					net_server_send(socketID_sender, CODE_CHANGE_BOX_POSITION, data[0]+"|"+data[1]+"|"+data[2]+"|"+data[3], BUFFER_TYPE_STRING)
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_PING:
				net_server_send(socketID_sender, CODE_PING, data[0], BUFFER_TYPE_INT32, true)
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_SKILL1:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				instance.image_angle = data[0]
				var arrow = cast_skill(1, instance)
				if (arrow != undefined) {
					arrow.image_angle = data[0]
					var pow = 1400
					arrow.spd = {xx: lengthdir_x(pow, data[0]), yy: lengthdir_y(pow, data[0])}
				
					net_server_send(SOCKET_ID_ALL, CODE_SKILL1, string(socketID_sender)+"|"+string(arrow.x)+"|"+string(arrow.y)+"|"+string(arrow.image_angle), BUFFER_TYPE_STRING)
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_SKILL2:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				instance.image_angle = data[0]
				var laser = cast_skill(2, instance)
				if (laser != undefined) {
					with (laser) {
						image_angle = instance.image_angle
						event_user(0)
					}
				}
				break
				
			case _CODE_GET_ACTIVE_QUESTS:
				send_active_quests(socketID_sender)
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_SKILL3:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				var skill = cast_skill(3, instance)
				if (skill != undefined)
					net_server_send(SOCKET_ID_ALL, CODE_SKILL3, socketID_sender, BUFFER_TYPE_INT16)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_MOUSE_POSITION:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				with (instance) {
					var dir = point_direction(x, y, data[0], data[1])
					image_angle = dir
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
				
			case _CODE_DELETE_QUEST:
				var accountID = db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_ACCID_SERVER, ONLINEACCOUNTS_SOCKETID_SERVER, socketID_sender)
				if (accountID == undefined)
					break
					
				ds_map_delete(global.playerQuests[? accountID], data[0])	
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_KEYPRESS:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				with (instance) {
					switch (data[0]) {
						case 1:
							key_w = true
							break
						
						case 2:
							key_a = true
							break
						
						case 3:
							key_s = true
							break
						
						case 4:
							key_d = true
							break
					}
				}
				break
			
			/* // // // // // // // // // // // // // // // // // // // // // // // //
			--------------------------------------------------------------------------
			--------------------------------------------------------------------------
			--------------------------------------------------------------------------
			--------------------------------------------------------------------------
			--------------------------------------------------------------------------
			--------------------------------------------------------------------------
			--------------------------------------------------------------------------
			// // // // // // // // // // // // // // // // // // // // // // // // */
			
			case CODE_TELL_PLAYER_POSITION:
				var _socketID = real(data[0])
		
				var player = global.playerInstances[? _socketID]
				if (player != undefined) {
					player.x = real(data[1])
					player.y = real(data[2])
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_NPC_POSITION:
				var npcID = real(data[0])
		
				var creature = global.creatureInstances[? npcID]
				if (creature != undefined) {
					creature.x = real(data[1])
					creature.y = real(data[2])
				}
				break
		
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_PLAYER_NAME:
				var _socketID = real(data[0])
				var player = global.playerInstances[? _socketID]
			
				ds_map_set(global.playerNames, _socketID, data[1])
				if (_socketID == global.socketID_player)
					global.clientName = data[1]
				if (player != undefined)
					player.name = data[1]
				break
		
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_PLAYER_HP:
				var player = global.playerInstances[? real(data[0])]
			
				if (player != undefined)
					player.hp = real(data[1])
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_NPC_HP:
				var creature = global.creatureInstances[? real(data[0])]
			
				if (creature != undefined)
					creature.hp = real(data[1])
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_PLAYER_MANA:
				var player = global.playerInstances[? real(data[0])]
			
				if (player != undefined)
					player.mana = real(data[1])
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_NPC_MANA:
				var creature = global.creatureInstances[? real(data[0])]
			
				if (creature != undefined)
					creature.mana = real(data[1])
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_PLAYER_MAXMANA:
				var player = global.playerInstances[? real(data[0])]
			
				if (player != undefined) {
					player.maxMana = real(data[1])
					player.mana = min(player.maxMana, player.mana)
					player.manaBarP = player.mana/player.maxMana
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_PLAYER_MAXENERGY:
				var player = global.playerInstances[? real(data[0])]
			
				if (player != undefined) {
					player.energy = real(data[1])
					player.energy = min(player.maxEnergy, player.energy)
				}
				break

			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_NPC_ENERGY:
				var creature = global.creatureInstances[? real(data[0])]
			
				if (creature != undefined)
					creature.energy = real(data[1])
				break
		
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_PLAYER_ROTATION:
				var player = global.playerInstances[? real(data[0])]
			
				if (player != undefined)
					player.image_angle_target = real(data[1])
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_NPC_ROTATION:
				var creature = global.creatureInstances[? real(data[0])]
			
				if (creature != undefined)
					creature.image_angle_target = real(data[1])
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_PLAYER_ENERGY:
				var player = global.playerInstances[? real(data[0])]
			
				if (player != undefined)
					player.energy = real(data[1])
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_PLAYER_MAXHP:
				var player = global.playerInstances[? real(data[0])]
			
				if (player != undefined) {
					player.maxHp = real(data[1])
					player.hp = min(player.maxHp, player.hp)
					player.healthBarP = player.hp/player.maxHp
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_PLACE_OBSTACLES:
				var obstacleCreator = instance_create(real(data[0]), real(data[1]), objObstacleCreator)
				with (obstacleCreator) {
					obstacleSprite = sprRockGrid
					image_xscale = real(data[2])
					image_yscale = real(data[3])
					image_angle = real(data[4])
				
					polygon = polygon_from_instance(id)
					event_user(0)
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_PLACE_LIGHTS:
				var light = instance_create(real(data[0]), real(data[1]), objLight)
				with (light) {
					Light_Range = real(data[2])
					Light_Intensity = real(data[3])
					Light_Color = real(data[4])
					Light_Shadow_Length = real(data[5])
					Light_Angle = 0
					Light_Direction = 0
	
					recreate_light()
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_PLACE_TREES:
				var tree
			
				if (data[0] == 1)
					tree = instance_create_layer(real(data[1]), real(data[2]), "Top", objTree)
				else if (data[0] == 2)
					tree = instance_create_layer(real(data[1]), real(data[2]), "Top", objTree2)
				else if (data[0] == 3)
					tree = instance_create_layer(real(data[1]), real(data[2]), "Top", objTree3)
				else if (data[0] == 4)
					tree = instance_create_layer(real(data[1]), real(data[2]), "Top", objTree4)
			
				tree.image_angle = real(data[3])
				tree.image_xscale = real(data[4])
				tree.image_yscale = real(data[5])
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_PLACE_LAKES:
				var lake
			
				if (data[0] == 1)
					lake = instance_create_layer(real(data[1]), real(data[2]), "Below", objLake)
				else if (data[0] == 2)
					lake = instance_create_layer(real(data[1]), real(data[2]), "Below", objLake2)
			
				lake.image_angle = real(data[3])
				lake.image_xscale = real(data[4])
				lake.image_yscale = real(data[5])
				break
		}
	}
	catch (error) {
		global.networkErrors_count++
		show_message(error)
	}
}