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
			case CODE_CONNECT:
				var _socketID = real(data[0])
				if (global.socketID_player == undefined)
					global.socketID_player = _socketID
				
				if (global.serverIP == "127.0.0.1")
					net_client_send(_CODE_LOGIN, global.clientID+"|"+global.clientPassword+"|"+global.clientName+"|"+global.clientClass, BUFFER_TYPE_STRING)
				else {
					ini_open("boxes.dbfile")
						var _str = ini_read_string("Boxes", global.clientID, "")
						if (_str == "")
							_str = "undefined"
					ini_close()
						
					var account = db_get_row(global.DB_SRV_TABLE_accounts, global.clientID)
					if (account != undefined)
						net_client_send(_CODE_UPLOAD, global.clientID+"|"+global.clientPassword+"|"+account[? ACCOUNTS_NICKNAME_SERVER]+"|"+account[? ACCOUNTS_CLASS_SERVER]+"|"+_str+"|"+string(global.gold), BUFFER_TYPE_STRING)
					else
						net_client_send(_CODE_UPLOAD, global.clientID+"|"+global.clientPassword+"|"+global.clientName+"|"+global.clientClass+"|"+_str+"|"+string(global.gold), BUFFER_TYPE_STRING)
				}
				break
		
			case CODE_OBSTACLES:
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
			
			case CODE_LIGHTS:
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
			
			case CODE_TREES:
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
				
			case CODE_LAKES:
				var lake
			
				if (data[0] == 1)
					lake = instance_create_layer(real(data[1]), real(data[2]), "Below", objLake)
				else if (data[0] == 2)
					lake = instance_create_layer(real(data[1]), real(data[2]), "Below", objLake2)
			
				lake.image_angle = real(data[3])
				lake.image_xscale = real(data[4])
				lake.image_yscale = real(data[5])
				break
		
			case CODE_DISCONNECT:
				var player = global.playerInstances[? real(data[0])]
				if (player != undefined)
					instance_destroy(player)
				break
			
			case CODE_LOGIN_FAIL:
				room_goto(roomMenu)
				break
			
			case CODE_PING:
				global.ping_udp = current_time-real(data[0])
				break
			
			case CODE_SPAWN_PLAYER:
					var _socketID = real(data[0])
		
					var newPlayer = instance_create_layer(real(data[1]), real(data[2]), "Normal", _socketID == global.socketID_player ? objPlayer : objOtherPlayer)
					newPlayer.socketID = _socketID
					newPlayer.maxHp = real(data[3])
					newPlayer.maxEnergy = real(data[4])
					newPlayer.maxMana = real(data[5])
					newPlayer.class = data[6]

					newPlayer.hp = newPlayer.maxHp
					newPlayer.energy = newPlayer.maxEnergy
					newPlayer.mana = newPlayer.maxMana
					newPlayer.rigidbody_set_definedstance(STANCE_NORMAL, 0.5)
					newPlayer.name = ds_map_find_value(global.playerNames, _socketID)
				
					switch (newPlayer.class) {
						case CLASS_WARRIOR:
							newPlayer.shoulders.sprite_index = sprClothes_000
							newPlayer.hair = sprHair_000
							break
						
						case CLASS_ASSASSIN:
							newPlayer.shoulders.sprite_index = sprClothes_000
							newPlayer.hair = sprHair_001
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
			
			case CODE_SPAWN_CREATURE:
					var _creatureID = real(data[0])
		
					var creature = instance_create_layer(real(data[1]), real(data[2]), "Normal", objCreature1)
					creature.creatureID = _creatureID
					creature.maxHp = real(data[3])
					creature.maxEnergy = real(data[4])
					creature.maxMana = real(data[5])

					creature.hp = creature.maxHp
					creature.energy = creature.maxEnergy
					creature.mana = creature.maxMana
					creature.rigidbody_set_definedstance(STANCE_NORMAL, 0.5)
					creature.name = data[6]
				
					ds_map_set(global.creatureInstances, _creatureID, creature)
				break
				
			case CODE_LOGIN_SUCCESS:
				with (parPlayer)
					if (socketID == global.socketID_player)
						instance_destroy()
		
				with (contClient)
					alarm[1] = -1
				break
			
			case CODE_UPLOAD_SUCCESS:
				if (global.serverIP == data[0] and global.clientID == data[1] and global.clientName == data[2] and global.clientPassword == data[3] and global.clientClass == data[4])
					with (contClient) {
						alarm[0] = SEC
						alarm[1] = SEC*2
					}
				break
				
			case CODE_CHANGE_ACTIVE_BOX:
				if (data[1] != "undefined")
					change_active_box(real(data[0]), real(data[1]), real(data[2]), data[3])
				else
					change_active_box(real(data[0]), undefined, undefined, data[3])
				break
				
			case CODE_CHANGE_BOX_POSITION:
				change_box_position(real(data[0]), real(data[1]), real(data[2]), real(data[3]))
				break
				
			case CODE_APPEARENCE:
				var player = global.playerInstances[? real(data[0])]
				
				if (player != undefined)
					with (player) {
						id.weaponSprite = asset_get_index(data[1])
						shoulders.sprite_index = asset_get_index(data[2])
						//hair = asset_get_index(data[3])
					}
				break
				
			case CODE_GET_BOXES:
				ds_grid_destroy(global.boxes)
				
				var boxes_SERVER = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
				ds_grid_read(boxes_SERVER, data[0])
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
					
				break
		
			case CODE_TELL_PLAYER_POSITION:
				var _socketID = real(data[0])
		
				var player = global.playerInstances[? _socketID]
				if (player != undefined) {
					player.x = real(data[1])
					player.y = real(data[2])
				}
				break
			
			case CODE_TELL_CREATURE_POSITION:
				var creatureID = real(data[0])
		
				var creature = global.creatureInstances[? creatureID]
				if (creature != undefined) {
					creature.x = real(data[1])
					creature.y = real(data[2])
				}
				break
		
			case CODE_TELL_PLAYER_NAME:
				var _socketID = real(data[0])
				var player = global.playerInstances[? _socketID]
			
				ds_map_set(global.playerNames, _socketID, data[1])
				if (player != undefined)
					player.name = data[1]
				break
		
			case CODE_TELL_PLAYER_HP:
				var player = global.playerInstances[? real(data[0])]
			
				if (player != undefined)
					player.hp = real(data[1])
				break
			
			case CODE_TELL_CREATURE_HP:
				var creature = global.creatureInstances[? real(data[0])]
			
				if (creature != undefined)
					creature.hp = real(data[1])
				break
			
			case CODE_TELL_PLAYER_MANA:
				var player = global.playerInstances[? real(data[0])]
			
				if (player != undefined)
					player.mana = real(data[1])
				break
			
			case CODE_TELL_CREATURE_MANA:
				var creature = global.creatureInstances[? real(data[0])]
			
				if (creature != undefined)
					creature.mana = real(data[1])
				break
			
			case CODE_SET_WALLET:
				global.gold = data[0]
			break
		
			case CODE_TELL_PLAYER_ENERGY:
				var player = global.playerInstances[? real(data[0])]
			
				if (player != undefined)
					player.energy = real(data[1])
				break
				
			case CODE_TELL_PLAYER_MAXHP:
				var player = global.playerInstances[? real(data[0])]
			
				if (player != undefined) {
					player.maxHp = real(data[1])
					player.hp = min(player.maxHp, player.hp)
					player.healthBarP = player.hp/player.maxHp
				}
				break
				
			case CODE_DROP_COIN:
				var coinCenter = instance_create_layer(real(data[1]), real(data[2]), "Floor", objCoinCenter)
				coinCenter.value = real(data[3])
				coinCenter.id_server = real(data[0])
				break
				
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
				
			case CODE_TELL_PLAYER_MAXMANA:
				var player = global.playerInstances[? real(data[0])]
			
				if (player != undefined) {
					player.maxMana = real(data[1])
					player.mana = min(player.maxMana, player.mana)
					player.manaBarP = player.mana/player.maxMana
				}
				break
				
			case CODE_TELL_PLAYER_MAXENERGY:
				var player = global.playerInstances[? real(data[0])]
			
				if (player != undefined) {
					player.energy = real(data[1])
					player.energy = min(player.maxEnergy, player.energy)
				}
				break

			case CODE_TELL_CREATURE_ENERGY:
				var creature = global.creatureInstances[? real(data[0])]
			
				if (creature != undefined)
					creature.energy = real(data[1])
				break
		
			case CODE_TELL_PLAYER_ROTATION:
				var player = global.playerInstances[? real(data[0])]
			
				if (player != undefined)
					player.image_angle_target = real(data[1])
				break
			
			case CODE_TELL_CREATURE_ROTATION:
				var creature = global.creatureInstances[? real(data[0])]
			
				if (creature != undefined)
					creature.image_angle_target = real(data[1])
				break
			
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
			
			case CODE_KILL:
				var target = global.playerInstances[? real(data[0])]
				if (target == undefined)
					target = global.creatureInstances[? real(data[0])]
		
				if (target != undefined)
					instance_destroy(target)
				break
			
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
			
			case CODE_SKILL_INFO:
				with (objPlayer) {
					var skill = skills[real(data[1])]
					skill.index = real(data[0])
					skill.code = real(data[5])
					skill.maxcooldown = real(data[2])
					skill.energy = real(data[3])
					skill.mana = real(data[4])
				}
				break
			
			case CODE_TEXT:
				var target = global.playerInstances[? real(data[0])]
				if (target == undefined)
					target = global.creatureInstances[? real(data[0])]
		
				if (target != undefined)
					with (target) {
						var _text = {xx: real(data[1]), yy: real(data[2]), text: data[3], life: real(data[4]), spd_x: real(data[5]), spd_y: real(data[6]), color: real(data[7]), size: real(data[8]), maxlife: real(data[4])}
						ds_list_add(texts, _text)
					}
				break
			
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
			
			case CODE_LASER:
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
				
			case _CODE_LOGIN:
				var onlineAccount = db_find_value(global.DB_SRV_TABLE_onlineAccounts, ONLINEACCOUNTS_SOCKETID_SERVER, ONLINEACCOUNTS_ACCID_SERVER, data[0])
				if (onlineAccount != undefined) {
					net_server_send(socketID_sender, CODE_LOGIN_FAIL)
					break
				}

				var account = db_get_row(global.DB_SRV_TABLE_accounts, data[0])
				if (account != undefined and account[? ACCOUNTS_PASSWORD_SERVER] == data[1] and data[2] == "" or account == undefined and data[1] != "" and data[2] != "") {
					if (account == undefined or account[? ACCOUNTS_PASSWORD_SERVER] == data[1]) {
						if (account == undefined) {
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
					
					var walletRow = db_get_row(global.DB_SRV_TABLE_wallets, onlineAccount[? ONLINEACCOUNTS_ACCID_SERVER])
					if (walletRow == undefined) {
						walletRow = db_create_row(data[0])
						walletRow[? WALLETS_GOLD_SERVER] = 0
						db_add_row(global.DB_SRV_TABLE_wallets, walletRow)
					}
				
				
					ini_open("boxes.dbfile")
						var _str = ini_read_string("Boxes", string(data[0]), "")
					ini_close()
					
					if (global.playerBoxes[? socketID_sender] == undefined) {
						if (_str != "") {
							var value = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
							ds_grid_read(value, _str)
						
							for (var k = 0; k < global.bc_hor_COMMON*global.pageCount_COMMON; k++)
								for (var z = 0; z < global.bc_ver_COMMON+2; z++) {
									var box = json_parse(ds_grid_get(value, k, z))
									ds_grid_set(value, k, z, box)
									if (box.item == pointer_null)
										box.item = undefined
									else
										box.item = get_item_COMMON(box.item.code)
								}
							
							ds_map_add(global.playerBoxes, string(data[0]), value)
						}
						else {
							boxes_SERVER = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
							for (var t = 0; t < global.bc_hor_COMMON*global.pageCount_COMMON; t++)
								for (var z = 0; z < global.bc_ver_COMMON+2; z++)
									ds_grid_set(boxes_SERVER, t, z, global.boxEmpty_COMMON)
	
							ds_grid_set(boxes_SERVER, 0, 0, {item: get_item_COMMON(SWORD_000), tag: {isActive: false, isForQuest: false}, count: 1})
							ds_grid_set(boxes_SERVER, 1, 0, {item: get_item_COMMON(SWORD_001), tag: {isActive: false, isForQuest: false}, count: 1})
							ds_grid_set(boxes_SERVER, 2, 0, {item: get_item_COMMON(SWORD_002), tag: {isActive: false, isForQuest: false}, count: 1})
							ds_grid_set(boxes_SERVER, 0, 1, {item: get_item_COMMON(SWORD_003), tag: {isActive: false, isForQuest: false}, count: 1})
							ds_grid_set(boxes_SERVER, 1, 1, {item: get_item_COMMON(CLOTHES_000), tag: {isActive: false, isForQuest: false}, count: 1})
							ds_grid_set(boxes_SERVER, 2, 1, {item: get_item_COMMON(CLOTHES_001), tag: {isActive: false, isForQuest: false}, count: 1})
							ds_grid_set(boxes_SERVER, 0, 2, {item: get_item_COMMON(CLOTHES_002), tag: {isActive: false, isForQuest: false}, count: 1})
							ds_grid_set(boxes_SERVER, 1, 2, {item: get_item_COMMON(CLOTHES_003), tag: {isActive: false, isForQuest: false}, count: 1})
						
							ds_map_add(global.playerBoxes, string(data[0]), boxes_SERVER)
						}
					}
				
					with (objRock_SERVER)
						net_server_send(socketID_sender, CODE_OBSTACLES, string(round(x))+"|"+string(round(y))+"|"+string(image_xscale)+"|"+string(image_yscale)+"|"+string(round(image_angle)), BUFFER_TYPE_STRING)
			
					with (objLight_SERVER)
						net_server_send(socketID_sender, CODE_LIGHTS, string(round(x))+"|"+string(round(y))+"|"+string(Light_Range)+"|"+string(Light_Intensity)+"|"+string(Light_Color)+"|"+string(Light_Shadow_Length), BUFFER_TYPE_STRING)
				
					with (objTree_SERVER)
						net_server_send(socketID_sender, CODE_TREES, string(type)+"|"+string(round(x))+"|"+string(round(y))+"|"+string(image_angle)+"|"+string(image_xscale)+"|"+string(image_yscale), BUFFER_TYPE_STRING)
				
					with (objLake_SERVER)
						net_server_send(socketID_sender, CODE_LAKES, "1|"+string(round(x))+"|"+string(round(y))+"|"+string(image_angle)+"|"+string(image_xscale)+"|"+string(image_yscale), BUFFER_TYPE_STRING)
				
					with (objLake2_SERVER)
						net_server_send(socketID_sender, CODE_LAKES, "2|"+string(round(x))+"|"+string(round(y))+"|"+string(image_angle)+"|"+string(image_xscale)+"|"+string(image_yscale), BUFFER_TYPE_STRING)
				
					with (objPlayer_SERVER)
						if (id.socketID != socketID_sender) {
							net_server_send(socketID_sender, CODE_SPAWN_PLAYER, string(id.socketID)+"|"+string(x)+"|"+string(y)+"|"+string(maxHp)+"|"+string(maxEnergy)+"|"+string(maxMana)+"|"+string(class), BUFFER_TYPE_STRING)
							send_appearence_to_all_SERVER(id.socketID, socketID_sender)
						}
				
					with (objCreature1)
						net_server_send(socketID_sender, CODE_SPAWN_CREATURE, string(targetID)+"|"+string(x)+"|"+string(y)+"|"+string(maxHp)+"|"+string(maxEnergy)+"|"+string(maxMana)+"|"+string(name), BUFFER_TYPE_STRING)
	
					net_server_send(socketID_sender, CODE_LOGIN_SUCCESS, account[? ACCOUNTS_CLASS_SERVER], BUFFER_TYPE_STRING)
					
					net_server_send(socketID_sender, CODE_GET_BOXES, get_boxes_grid_SERVER(socketID_sender), BUFFER_TYPE_STRING)
					
					net_server_send(socketID_sender, CODE_SET_WALLET, walletRow[? WALLETS_GOLD_SERVER], BUFFER_TYPE_INT32) // ?
	
					var instance = spawn_player(socketID_sender)
					instance.name = account[? ACCOUNTS_NICKNAME_SERVER]
				
					tell_all_names()
					tell_all_positions_SERVER(true)
				}
				else
					net_server_send(socketID_sender, CODE_LOGIN_FAIL)
				break
		
			case _CODE_LEFT_CLICK:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				with (instance) {
					var dir = point_direction(x, y, data[0], data[1])
					/*if (phy_speed < 10)
						physics_apply_impulse(phy_com_x, phy_com_y, lengthdir_x(1, dir), lengthdir_y(1, dir))*/
				
					movement_x = data[0]
					movement_y = data[1]
					image_angle = dir
				}
				break
			
			case _CODE_MOUSE_POSITION:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				with (instance) {
					var dir = point_direction(x, y, data[0], data[1])
					image_angle = dir
				}
				break
			
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
				
			case _CODE_UPLOAD:
				var accountRow = db_get_row(global.DB_SRV_TABLE_accounts, data[0])
				if (accountRow != undefined and accountRow[? ACCOUNTS_PASSWORD_SERVER] != data[1])
					break
					
				if (data[0] == "" or data[1] == "")
					break
					
				if (global.playerBoxes[? socketID_sender] != undefined)
					ds_grid_destroy(global.playerBoxes[? socketID_sender])
				
				if (data[4] != "undefined") {
					var boxes_TAKEN = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
					ds_grid_read(boxes_TAKEN, data[4])
					for (var i = 0; i < global.bc_hor_COMMON*global.pageCount_COMMON; i++) {
						for (var j = 0; j < global.bc_ver_COMMON+2; j++) {
							var _data = ds_grid_get(boxes_TAKEN, i, j)
						
							var _box = json_parse(_data)
							if (_box.item == pointer_null)
								_box.item = undefined
							
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
				
				var walletRow = db_create_row(data[0])
				walletRow[? WALLETS_GOLD_SERVER] = real(data[5])
				db_add_row(global.DB_SRV_TABLE_wallets, walletRow)
				db_save_table(global.DB_SRV_TABLE_wallets)
				
				_net_receive_packet(_CODE_LOGIN, data[0]+"|"+data[1]+"|"+(accountRow != undefined ? "" : data[2])+"|"+(accountRow != undefined ? "" : data[3]), socketID_sender)
				break
			
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
			
			case _CODE_SKILL0:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				var skill = cast_skill(0, instance)
				if (skill != undefined)
					net_server_send(SOCKET_ID_ALL, CODE_SKILL0, socketID_sender, BUFFER_TYPE_INT32)
				break
				
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
				
			case _CODE_GET_BOXES:
				net_server_send(socketID_sender, CODE_GET_BOXES, get_boxes_grid_SERVER(socketID_sender), BUFFER_TYPE_STRING)
				break
				
			case _CODE_DROP_COIN:
				var coinCenter = instance_create(real(data[0]), real(data[1]), objCoinCenter_SERVER)
				coinCenter.value = 20
				net_server_send(SOCKET_ID_ALL, CODE_DROP_COIN, string(coinCenter)+"|"+string(coinCenter.x)+"|"+string(coinCenter.y)+"|"+string(coinCenter.value), BUFFER_TYPE_STRING)
				break
				
			case _CODE_CHANGE_BOX_POSITION:
				if (change_box_position_SERVER(socketID_sender, real(data[0]), real(data[1]), real(data[2]), real(data[3]))) {
					net_server_send(socketID_sender, CODE_CHANGE_BOX_POSITION, data[0]+"|"+data[1]+"|"+data[2]+"|"+data[3], BUFFER_TYPE_STRING)
				}
				break
			
			case _CODE_PING:
				net_server_send(socketID_sender, CODE_PING, data[0], BUFFER_TYPE_INT32, true)
				break
			
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
			
			case _CODE_SKILL3:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				var skill = cast_skill(3, instance)
				if (skill != undefined)
					net_server_send(SOCKET_ID_ALL, CODE_SKILL3, socketID_sender, BUFFER_TYPE_INT16)
				break
		}
	}
	catch (error) {
		global.networkErrors_count++
		show_message(error)
	}
}