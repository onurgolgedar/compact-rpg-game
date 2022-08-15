function _net_receive_packet(code, pureData, socketID_sender, bufferinfo, bufferType, asyncMap, coopInfo) {
	if (global.playerControlMode_SERVER and instance_exists(global.selectedPlayer_SERVER)) {
		if (socketID_sender == global.socketID_player)
			socketID_sender = global.selectedPlayer_SERVER.socketID
		else
			exit
	}
	
	var data
	var dataWillBeDeleted = false
	#region PARSE PARAMETERS
	var parameterCount = 0
	if (is_string(pureData)) {
		if (string_char_at(pureData, 1) == "{" or string_char_at(pureData, 1) == "[") {
			dataWillBeDeleted = true
			data = json_parse(pureData)
		}
		else {
			parameterCount = 1
			data = pureData
		}
	}
	else {
		parameterCount = 1
		data = pureData
	}
	#endregion
	
	/*if (code != 2002 and code != 2001 and code != 2005 and code != 2003 and code != 2004 and
		code != 3005 and code != 3000 and code != 3001 and code != 3002 and code != 3003 and
		code != 1000 and code != 1001 and code != 1002 and code != 1003 and code != 1004 and
		code != 2000 and code != 2002 and code != 7003 and code != 2007 and
		code != 2006 and code != 1500 and code != 7001 and code != 5000 and code != 1501 and
		code != 3004 and code != 5002 and code != 15002 and code != 10302 and code != 4001 and
		code != 6000 and code != 10300 and code != 10301 and code != 10301 and code != 7010 and
		code != 17010 and code != 652 and code != 8000 and code != 18000)
		//if (!is_string(pureData) or string_length(pureData) < 100)
			//show_messagebox(50, 150, "From: "+string(socketID_sender), "Code: "+string(code)+"\n"+string(data), 7)
			show_debug_message("From: "+string(socketID_sender)+"\n[ Code: "+string(code)+"\n  Data: "+string(data)+" ]")*/
			
	if (!global.drawEventEnabled_SERVER and (code == CODE_TELL_NPC_ENERGY or code == CODE_TELL_NPC_HP or code == CODE_TELL_NPC_MANA or
		code == CODE_TELL_NPC_POSITION or code == CODE_TELL_NPC_ROTATION or code == CODE_TELL_PLAYER_ENERGY or code == CODE_TELL_PLAYER_HP or
		code == CODE_TELL_PLAYER_MANA or code == CODE_TELL_PLAYER_POSITION or code == CODE_TELL_PLAYER_ROTATION))
		exit

	//try {
		switch(code) {										
			case CODE_GET_INVENTORY:
				for (var i = 0; i < global.bc_hor_COMMON*global.pageCount_COMMON; i++) {
					for (var j = 0; j < global.bc_ver_COMMON+2; j++) {
						var box = ds_grid_get(global.boxes, i, j)
						if (is_struct(box))
							delete box
					}
				}
				ds_grid_destroy(global.boxes)
				
				var boxes_SERVER = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
				ds_grid_read(boxes_SERVER, data.boxes)
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

				with (objinventory_window)
					inventory_refresh()
					
				global.gold = data.gold
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_GET_INVENTORY_SKILL:
				for (var i = 0; i < global.sc_hor_COMMON*global.pageCount_skill_COMMON; i++) {
					for (var j = 0; j < global.sc_ver_COMMON; j++) {
						var box = ds_grid_get(global.boxes_skill, i, j)
						if (is_struct(box))
							delete box
					}
				}
				ds_grid_destroy(global.boxes_skill)
				
				var boxes_skill_SERVER = ds_grid_create(global.sc_hor_COMMON*global.pageCount_skill_COMMON, global.sc_ver_COMMON)
				ds_grid_read(boxes_skill_SERVER, data.grid)
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
				
				global.skillPoints = data.skillPoints

				with (objSkills_window)
					skills_refresh()
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_APPEARENCE:
				var player = global.playerInstances[? data.socketID]
				if (player == undefined)
					break
				
				with (player) {
					real(id).weaponSprite = asset_get_index(data.weapon)
					shoulders.sprite_index = asset_get_index(data.shoulders)
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_WINDOW:
				if (not_undefined_not_null_COMMON(data.ownerID) or !instance_exists(data.ownerID))
					break
			
				var trade_window = instance_create_layer(450, 140, "Windows", asset_get_index(data.window))
				trade_window.owner = data.ownerID
			
				var boxes = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
				ds_grid_read(boxes, data.json)
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
				global.gold = data
			break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_BOX_CHANGE_ACTIVE:
				if (data.i != pointer_null)
					box_change_active(data.type, data.i, data.j, data.confirmation)
				else
					box_change_active(data.type, undefined, undefined, data.confirmation)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_BOX_CHANGE_POSITION:
				box_change_position(data.i, data.j, data.target_i, data.target_j)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_DROP_COIN:
				var coinCenter = instance_create_layer(data.xx, data.yy, "Floor", objCoinCenter)
				coinCenter.value = data.value
				coinCenter.id_server = data.coinID
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_COLLECT_COIN:
				var player = global.playerInstances[? data.socketID]
				if (player == undefined)
					break
				
				// ?
				with (objCoinCenter) {
					if (id_server = data.coinID) {
						collector = player
							
						var ds_size = ds_list_size(coins)
						for (var i = 0; i < ds_size; i++) {
							var coin = ds_list_find_value(coins, i)
							coin.moving = true
							coin.collector = player

							with (coin) {
								var pow = 120
								var dir = point_direction(x, y, player.x, player.y)
								ds_map_add(spds, irandom(999999), { xx: lengthdir_x(pow, dir), yy: lengthdir_y(pow, dir) })
							}
						}
							
						break
					}
				}
				
				if (global.socketID_player == data.socketID)
					global.gold = data.value
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_EFFECT_LASER:
				var target = global.playerInstances[? data]
				if (target == undefined) {
					target = global.npcInstances[? data]
					if (target == undefined)
						break
				}
		
				with (target) {
					var effect = instance_create_layer(x, y, "Top", efLaser)
					effect.target = real(id)
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_KILL:
				var target = global.playerInstances[? data]
				if (target == undefined) {
					target = global.npcInstances[? data]
					if (target == undefined)
						break
				}
		
				instance_destroy(target)
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_BASIC_ATTACK:
				var player = global.playerInstances[? data.socketID]
				if (player == undefined)
					break
		
				with (contGameController)
					ba_delay = 0
					
				with (player) {
					var sound = sound_play_at(sndSwordSwing, x, y, false)
					audio_sound_pitch(sound, random_range(0.85, 1.05))
						
					anim_start(animSwingASword, data.time, real(id), animSwingASword_style)

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
					if (data.index != pointer_null) {
						var skill = skills[data.key]
						skill.index = data.index
						skill.code = data.code
						skill.cooldown = data.cooldown
						skill.cooldownmax = data.cooldownmax
						skill.energy = data.energy
						skill.mana = data.mana
						skill.upgrade = data.upgrade
						skill.sprite = get_skill_sprite(data.index)
					}
					else {
						var value = skills[data.key]
						if (is_struct(value))
							delete value
						skills[data.key] = new st_skill()
					}
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_SLIDING_TEXT:
				var target = global.playerInstances[? data.socketID]
				if (target == undefined) {
					target = global.npcInstances[? data.socketID]
					if (target == undefined)
						break
				}
		
				with (target) {
					var _text = { xx: data.xx, yy: data.yy, text: data.text, life: data.life, spd_x: data.spd_x, spd_y: data.spd_y, color: data.color, size: data.size, maxlife: data.maxlife }
					ds_list_add(texts, _text)
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
				
			case CODE_DIALOGUE:
				if (is_array(data)) {
					var messageBoxes = data
					
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
											
								var dialogueBox_object = show_questionbox(dialogueBox.xx, dialogueBox.yy, dialogueBox.title, dialogueBox.text, dialogueBox.ownerID, dialogueBox.messageID, buttonsArray)
								dialogueBox_object.dialogueNo = dialogueBox.dialogueNo
								dialogueBox_object.dialogueSize = dialogueBox.dialogueSize
							}
							else
								show_messagebox(messageBox.xx, messageBox.yy, messageBox.title, messageBox.text, messageBox.duration)
						}
					}
					
				}
				else {
					var buttonsArray = undefined
					if (data.buttonsArray != pointer_null) {
						buttonsArray = data.buttonsArray
						for (var i = 0; i < array_length(buttonsArray); i++)
							buttonsArray[i].image = asset_get_index(buttonsArray[i].image)
					}
				
					if (data.owner_assetName == pointer_null)
						data.owner_assetName = undefined
					if (data.ownerID == pointer_null)
						data.ownerID = undefined
					if (data.messageID == pointer_null)
						data.messageID = undefined
					if (data.duration == pointer_null)
						data.duration = undefined
					
					show_questionbox(450, 550, data.title, data.text, data.ownerID, data.messageID, buttonsArray, data.duration)
				}
				break
	
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_GET_STATISTICS:
				var target = global.playerInstances[? data.socketID]
				if (target == undefined)
					break

				with (target) {
					maxHp = data.maxHp
					maxEnergy = data.maxEnergy
					maxMana = data.maxMana
					movementSpeed = data.movementSpeed
					physicalPower = data.physicalPower
					magicalPower = data.magicalPower
					attackSpeed = data.attackSpeed
				}
			break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_GET_EFFECTBOXES:
				var target = global.playerInstances[? data.socketID]
				if (target == undefined)
					break

				with (target) {
					var effectBoxes_before = effectBoxes
					ds_list_read(effectBoxes, data.effectBoxes_str)
					if (effectBoxes == undefined) {
						effectBoxes = ds_list_create()
						ds_list_destroy(effectBoxes_before)
					}
					
					var ds_size = ds_list_size(effectBoxes)
					for (var i = 0; i < ds_size; i++) {
						effectBoxes[| i] = json_parse(effectBoxes[| i])
						
						var effectBox = effectBoxes[| i]
						effectBox.sprite = asset_get_index(effectBox.sprite)
					}
				}
			break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_CHAT:
				chat(data.title, data.txt, data.title == global.clientName ? c_ltyellow : c_ltorange)
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_SKILL0:
				var player = global.playerInstances[? data]
				if (player == undefined)
					break
			
				player.skill[0] = 0
				
				/*if (player.object_index == objPlayer) {
					for (var i = 0; i < 5; i++) {
						if (player.skills[i].index == SKILL_0) {
							player.skills[i].cooldown = player.skills[i].cooldownmax
							break
						}
					}
				}*/
				break

			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			
			case CODE_SKILL1:
				var player = global.playerInstances[? data.socketID]
				if (player == undefined)
					break
		
				with (player) {
					var arrow = instance_create_layer(data.xx, data.yy, "Top", objArrow)
					with (arrow) {
						image_angle = data.angle
						var pow = 1400
						arrow.spd = new st_speed(lengthdir_x(pow, image_angle), lengthdir_y(pow, image_angle))
						arrow.owner = player
					}
					
					/*if (player.object_index == objPlayer) {
						for (var i = 0; i < 5; i++) {
							if (player.skills[i].index == SKILL_1) {
								player.skills[i].cooldown = player.skills[i].cooldownmax
								break
							}
						}
					}*/
				}
				break
							
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_SKILL2:
				var player = global.playerInstances[? data.socketID]
				if (player == undefined)
					break
				
				with (player) {
					var laser = instance_create_layer(data.xx, data.yy, "Top", objSkill2)
					with (laser) {
						owner = player
						lock = data.lock
						image_blend = c_red
						image_angle = data.angle
						image_xscale = data.xscale
					}
					
					/*if (player.object_index == objPlayer) {
						for (var i = 0; i < 5; i++) {
							if (player.skills[i].index == SKILL_2) {
								player.skills[i].cooldown = player.skills[i].cooldownmax
								break
							}
						}
					}*/
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_LOCATION:
				instance_create_layer(0, 0, "Nirvana", contBlackScreen)
				net_client_send(_CODE_LOCATION, json_stringify({ set: data.set, value: data.value, xx: data.xx, yy: data.yy }), BUFFER_TYPE_STRING)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			
			case CODE_DAMAGED:
				var target = global.playerInstances[? data.targetID]
				if (target == undefined) {
					target = global.npcInstances[? data.targetID]
					if (target == undefined)
						break
				}
					
				with (target) {
					headOffset = 9*data.value
					var sound = sound_play_at(sndUh, x, y, false)
					audio_sound_pitch(sound, random_range(0.9, 1.05))
				}
				break 
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_SKILL3:
				var player = global.playerInstances[? data]
				if (player == undefined)
					break
					
				if (player.object_index == objPlayer) {
					for (var i = 0; i < 5; i++) {
						if (player.skills[i].index == SKILL_3) {
							player.skills[i].cooldown = player.skills[i].cooldownmax
							break
						}
					}
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_SPAWN_PLAYER:
				var newPlayer = instance_create_layer(data.xx, data.yy, "Normal", data.socketID == global.socketID_player ? objPlayer : objOtherPlayer)
				newPlayer.socketID = data.socketID
				newPlayer.maxHp = data.maxHp
				newPlayer.maxEnergy = data.maxEnergy
				newPlayer.maxMana = data.maxMana
				newPlayer.class = data.class
				newPlayer.movementSpeed = data.movementSpeed
				newPlayer.physicalPower = data.physicalPower
				newPlayer.magicalPower = data.magicalPower
				newPlayer.attackSpeed = data.attackSpeed
				newPlayer.level = data.level

				newPlayer.hp = newPlayer.maxHp
				newPlayer.energy = newPlayer.maxEnergy
				newPlayer.mana = newPlayer.maxMana
				newPlayer.rigidbody_set_definedstance(STANCE_NORMAL, 0.5)
				newPlayer.name = ds_map_find_value(global.playerNames, data.socketID)
					
				if (newPlayer.object_index == objPlayer) {
					camera_set_zoom(768*1.6, contCamera_COMMON.aspectRatio)
					
					global.clientClass = newPlayer.class
					global.level = newPlayer.level
					global.clientName = newPlayer.name
					if (global.selectedPlayer_SERVER == undefined)
						global.selectedPlayer_SERVER = real(newPlayer)
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
				
				ds_map_set(global.playerInstances, data.socketID, newPlayer)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_SPAWN_NPC:
				var _npcID = data.npcID
		
				var target = instance_create_layer(data.xx, data.yy, "Normal", asset_get_index(data.clientObject))
				target.npcID = _npcID
				target.maxHp = data.maxHp
				target.maxEnergy = data.maxEnergy
				target.maxMana = data.maxMana

				target.hp = target.maxHp
				target.energy = target.maxEnergy
				target.mana = target.maxMana
				target.rigidbody_set_definedstance(STANCE_NORMAL, 0.5)
				target.name = data.name
				
				ds_map_set(global.npcInstances, _npcID, target)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_GET_ACTIVE_QUESTS:
				var keys = ds_map_keys_to_array(global.activeQuests_player)//
				var ds_size = array_length(keys)
				for (var k = 0; k < ds_size; k++) {
					var quest = global.activeQuests_player[? keys[k]]
					if (is_struct(quest))
						delete quest
				}
				delete keys
			
				ds_map_read(global.activeQuests_player, data)
				
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
				delete keys
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_CONNECT:
				var _socketID = data
				if (global.socketID_player == undefined)
					global.socketID_player = _socketID
					
				if (global.connectionGoal == 0)
					net_client_send(_CODE_SIGNUP, json_stringify({ accountID: global.clientID_signup, password: global.clientPassword_signup, nickname: global.clientName_signup, class: global.clientClass_signup }), BUFFER_TYPE_STRING)
				else {
					if (global.serverIP == "127.0.0.1")
						net_client_send(_CODE_LOGIN, json_stringify({ accountID: global.clientID, password: global.clientPassword }), BUFFER_TYPE_STRING)
					else {						
						var accountinfo = db_get_row(global.DB_SRV_TABLE_accountinfo, global.clientID)
						
						if (accountinfo != undefined)
							upload_COMMON(global.clientID, global.clientPassword)
						else
							net_client_send(_CODE_LOGIN, json_stringify({ accountID: global.clientID, password: global.clientPassword }), BUFFER_TYPE_STRING)
					}
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
				
			case CODE_CONNECT_COOP:
				if (global.socketID_COOP_player == undefined)
					global.socketID_COOP_player = data
			
				if (global.clientID != "Local" and global.coopID != "")	
					with (contClient)
						alarm[3] = 1
				break
		
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_DISCONNECT:
				var player = global.playerInstances[? data]
				if (player != undefined)
					instance_destroy(player)
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_LOGIN_FAIL:

				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_PING:
				global.ping = current_time-data
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_LOGIN_SUCCESS:
				with (parPlayer)
					if (socketID == global.socketID_player)
						instance_destroy()
						
				global.clientClass = data
		
				with (contClient) {
					if (global.coopID == "" and global.publicGame)
						client_coop_connect(global.coopIP, PORT_TCP_COOP)
					alarm[1] = -1
				}
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
				var player = db_find_value(global.DB_SRV_TABLE_players, PLAYERS_SOCKETID_SERVER, PLAYERS_ACCID_SERVER, data.accountID)
				if (player != undefined) {
					net_server_send(socketID_sender, CODE_LOGIN_FAIL)
					break
				}
				
				var account = db_get_row(global.DB_SRV_TABLE_accounts, data.accountID)
				var accountinfoRow = db_get_row(global.DB_SRV_TABLE_accountinfo, data.accountID)
				if (account == undefined and accountinfoRow == undefined) {
					account = db_create_row(data.accountID)
					account[? ACCOUNTS_PASSWORD_SERVER] = data.password
					account[? ACCOUNTS_NICKNAME_SERVER] = data.nickname
						
					db_add_row(global.DB_SRV_TABLE_accounts, account)

					net_server_send(socketID_sender, CODE_DIALOGUE, json_stringify({ text: "You have [c="+string(c_ltlime)+"]signed up[/c] successfully. ", title: "Success", messageID: undefined, owner_assetName: undefined, ownerID: undefined, duration: 4, buttonsArray: undefined }), BUFFER_TYPE_STRING)
				}
				else
					net_server_send(socketID_sender, CODE_DIALOGUE, json_stringify({ text: "The account already exists. ", title: "Failed", messageID: undefined, owner_assetName: undefined, ownerID: undefined, duration: 4, buttonsArray: undefined }), BUFFER_TYPE_STRING)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_LOGIN:
				var player = db_find_value(global.DB_SRV_TABLE_players, PLAYERS_SOCKETID_SERVER, PLAYERS_ACCID_SERVER, data.accountID)
				if (player != undefined) {
					net_server_send(socketID_sender, CODE_LOGIN_FAIL)
					break
				}

				var account = db_get_row(global.DB_SRV_TABLE_accounts, data.accountID)
				var accountinfo = db_get_row(global.DB_SRV_TABLE_accountinfo, data.accountID)
				if (account != undefined and account[? ACCOUNTS_PASSWORD_SERVER] == data.password) {
					if (account[? ACCOUNTS_PASSWORD_SERVER] == data.password) {
						player = db_create_row(socketID_sender)
						player[? PLAYERS_ACCID_SERVER] = data.accountID
						player[? PLAYERS_LOCATION_SERVER] = accountinfo != undefined ? accountinfo[? ACCOUNTINFO_LOCATION_SERVER] : 1
						db_add_row(global.DB_SRV_TABLE_players, player)
					}
					else {
						net_server_send(socketID_sender, CODE_LOGIN_FAIL)
						break
					}
				
					ini_open("Boxes.dbfile")
						var _str_items = ini_read_string("Items", data.accountID, "")
						var _str_skills = ini_read_string("Skills", data.accountID, "")
						var _str_skillBoxes = ini_read_string("SkillBoxes", data.accountID, "")
						var _str_permanentEffectBoxes = ini_read_string("PermanentEffectBoxes", data.accountID, "")
					ini_close()
					
					ini_open("Quests.dbfile")
						var _str_quests = ini_read_string("Quests", data.accountID, "")
					ini_close()
					
					var accountinfoRow = db_get_row(global.DB_SRV_TABLE_accountinfo, data.accountID)
					if (accountinfoRow == undefined) {
						accountinfoRow = db_create_row(data.accountID)
						accountinfoRow[? ACCOUNTINFO_GOLD_SERVER] = 5000
						accountinfoRow[? ACCOUNTINFO_LEVEL_SERVER] = 1
						accountinfoRow[? ACCOUNTINFO_SKILLPOINTS_SERVER] = 3
						accountinfoRow[? ACCOUNTINFO_STATPOINTS_SERVER] = 10
						accountinfoRow[? ACCOUNTINFO_LOCATION_SERVER] = LOCATION_THE_CASTLE
						accountinfoRow[? ACCOUNTINFO_CLASS_SERVER] = CLASS_WARRIOR

						db_add_row(global.DB_SRV_TABLE_accountinfo, accountinfoRow)
					}
					
					cleanup_player_ds_SERVER(data.accountID)
					
					// Load Items
					if (_str_items != "") {
						var value = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
						ds_grid_read(value, _str_items)
						
						for (var k = 0; k < global.bc_hor_COMMON*global.pageCount_COMMON; k++)
							for (var z = 0; z < global.bc_ver_COMMON+2; z++) {
								var box = json_parse(ds_grid_get(value, k, z))
								ds_grid_set(value, k, z, box)
								if (box.item == pointer_null)
									box.item = undefined
								else {
									var itemUpgrade = box.item.upgrade
									box.item = item_get_COMMON(box.item.code, itemUpgrade)
								}
							}
							
						ds_map_add(global.playerBoxes_SERVER, data.accountID, value)
					}
					else {
						var boxes_SERVER = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
						for (var t = 0; t < global.bc_hor_COMMON*global.pageCount_COMMON; t++)
							for (var z = 0; z < global.bc_ver_COMMON+2; z++)
								ds_grid_set(boxes_SERVER, t, z, box_create_COMMON())
						
						ds_map_add(global.playerBoxes_SERVER, data.accountID, boxes_SERVER)
					}
					
					// Load Quests
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
						delete keys
							
						global.playerQuests_SERVER[? data.accountID] = value
							
						quests_set_SERVER(data.accountID)
					}
					else {
						global.playerQuests_SERVER[? data.accountID] = ds_map_create()

						ds_map_add(global.playerQuests_SERVER[? data.accountID], 1, new st_quest("Quest 1",,, 1,, "That's an example quest. You can test it.\nBy the way, this is a new line."))
						ds_map_add(global.playerQuests_SERVER[? data.accountID], 2, new st_quest("Quest 2",,, 2,, "That's an example quest. You can test it.\nBy the way, this is a new line."))
						ds_map_add(global.playerQuests_SERVER[? data.accountID], 3, new st_quest("Quest 3",,, 3,, "That's an example quest. You can test it.\nBy the way, this is a new line."))
						ds_map_add(global.playerQuests_SERVER[? data.accountID], 4, new st_quest("Quest 4",,, 4,, "That's an example quest. You can test it.\nBy the way, this is a new line."))
						ds_map_add(global.playerQuests_SERVER[? data.accountID], 5, new st_quest("Quest 5",,, 5,, "That's an example quest. You can test it.\nBy the way, this is a new line."))
						ds_map_add(global.playerQuests_SERVER[? data.accountID], 6, new st_quest("Quest 6",,, 6,, "That's an example quest. You can test it.\nBy the way, this is a new line."))
						ds_map_add(global.playerQuests_SERVER[? data.accountID], 7, new st_quest("Quest 7",,, 7,, "That's an example quest. You can test it.\nBy the way, this is a new line."))
						ds_map_add(global.playerQuests_SERVER[? data.accountID], 8, new st_quest("Quest 8",,, 8,, "That's an example quest. You can test it.\nBy the way, this is a new line."))
						ds_map_add(global.playerQuests_SERVER[? data.accountID], 9, new st_quest("Quest 9",,, 9,, "That's an example quest. You can test it.\nBy the way, this is a new line."))
						ds_map_add(global.playerQuests_SERVER[? data.accountID], 10, new st_quest("Quest 10",,, 10,, "That's an example quest. You can test it.\nBy the way, this is a new line."))
																					
						quests_set_SERVER(data.accountID)
					}
					
					// Load Skill Boxes
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
								if (value[? keys[k]].casttimemax == pointer_null)
									value[? keys[k]].casttimemax = undefined	
							}
						}
						delete keys
							
						global.playerSkillBoxes_SERVER[? data.accountID] = value
					}
					else
						global.playerSkillBoxes_SERVER[? data.accountID] = ds_map_create()
					
					// Load Permanent Effect Boxes
					if (_str_permanentEffectBoxes != "") {
						var value = ds_list_create()
						ds_list_read(value, _str_permanentEffectBoxes)
						
						var ds_size = ds_list_size(value)
						for (var k = 0; k < ds_size; k++)
							value[| k] = json_parse(value[| k])
							
						global.playerPermanentEffectBoxes_SERVER[? data.accountID] = value
					}
					else
						global.playerPermanentEffectBoxes_SERVER[? data.accountID] = ds_list_create()
					
					// Load Skill Tree
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
							
						ds_map_add(global.playerSkills_SERVER, data.accountID, value)
					}
					else {
						// Init Skill Tree
						var boxes_skill_SERVER = ds_grid_create(global.sc_hor_COMMON*global.pageCount_skill_COMMON, global.sc_ver_COMMON)
						for (var t = 0; t < global.sc_hor_COMMON*global.pageCount_skill_COMMON; t++)
							for (var z = 0; z < global.sc_ver_COMMON; z++)
								ds_grid_set(boxes_skill_SERVER, t, z, global.boxEmpty_skill_COMMON)
	
						ds_grid_set(boxes_skill_SERVER, 0, 0, { skill: get_skill_COMMON(SKILL_0, 0) })
						//ds_grid_set(boxes_skill_SERVER, 4, 0, { skill: get_skill_COMMON(SKILL_1, 0) })
						ds_grid_set(boxes_skill_SERVER, 0, 1, { skill: get_skill_COMMON(SKILL_2, 0) })
						ds_grid_set(boxes_skill_SERVER, 4, 1, { skill: get_skill_COMMON(SKILL_3, 0) })
						
						ds_map_add(global.playerSkills_SERVER, data.accountID, boxes_skill_SERVER)
					}
				
					// Map Creation
					with (objRock_SERVER)
						net_server_send(socketID_sender, CODE_PLACE_OBSTACLES, json_stringify({ xx: round(x), yy: round(y), xscale: image_xscale, yscale: image_yscale, angle: round(image_angle) }), BUFFER_TYPE_STRING)
			
					with (objLight_SERVER)
						net_server_send(socketID_sender, CODE_PLACE_LIGHTS, json_stringify({ xx: round(x), yy: round(y), range: Light_Range, intensity: Light_Intensity, color: Light_Color, shadow_length: Light_Shadow_Length }), BUFFER_TYPE_STRING)
				
					with (objTree_SERVER)
						net_server_send(socketID_sender, CODE_PLACE_TREES, json_stringify({ type: type, xx: round(x), yy: round(y), xscale: image_xscale, yscale: image_yscale, angle: round(image_angle) }), BUFFER_TYPE_STRING)
				
					with (objLake_SERVER)
						net_server_send(socketID_sender, CODE_PLACE_LAKES, json_stringify({ type: 1, xx: round(x), yy: round(y), xscale: image_xscale, yscale: image_yscale, angle: round(image_angle) }), BUFFER_TYPE_STRING)
				
					with (objLake2_SERVER)
						net_server_send(socketID_sender, CODE_PLACE_LAKES, json_stringify({ type: 2, xx: round(x), yy: round(y), xscale: image_xscale, yscale: image_yscale, angle: round(image_angle) }), BUFFER_TYPE_STRING)
				
					with (objPlayer_SERVER)
						if (real(id).socketID != socketID_sender) {
							net_server_send(socketID_sender, CODE_SPAWN_PLAYER, json_stringify({ socketID: real(id).socketID, xx: round(x), yy: round(y), maxHp: maxHp, maxEnergy: maxEnergy, maxMana: maxMana, class: class, movementSpeed: movementSpeed, physicalPower: physicalPower, magicalPower: magicalPower, attackSpeed: attackSpeed, level: level }), BUFFER_TYPE_STRING)
							tell_appearence_SERVER(real(id).socketID, socketID_sender)
						}
				
					with (objCreature1_SERVER)
						net_server_send(socketID_sender, CODE_SPAWN_NPC, json_stringify({ npcID: real(id).targetID, xx: round(x), yy: round(y), maxHp: maxHp, maxEnergy: maxEnergy, maxMana: maxMana, name: name, clientObject: object_get_name(clientObject) }), BUFFER_TYPE_STRING)
						
					with (objNPC_SERVER)
						net_server_send(socketID_sender, CODE_SPAWN_NPC, json_stringify({ npcID: real(id).targetID, xx: round(x), yy: round(y), maxHp: maxHp, maxEnergy: maxEnergy, maxMana: maxMana, name: name, clientObject: object_get_name(clientObject) }), BUFFER_TYPE_STRING)
	
					net_server_send(socketID_sender, CODE_LOGIN_SUCCESS, accountinfoRow[? ACCOUNTINFO_CLASS_SERVER], BUFFER_TYPE_STRING,,,)
					
					// Spawn Player
					var instance = player_spawn_SERVER(socketID_sender)
					
					// Send Private Data
					net_server_send(socketID_sender, CODE_GET_INVENTORY, json_stringify({ boxes: json_write_boxes_SERVER(socketID_sender), gold: accountinfoRow[? ACCOUNTINFO_GOLD_SERVER] }), BUFFER_TYPE_STRING)
					net_server_send(socketID_sender, CODE_GET_ACCOUNTINFO, accountinfoRow[? ACCOUNTINFO_GOLD_SERVER], BUFFER_TYPE_INT32)
				
					// Send Shared Data
					tell_all_names(,,true)
					tell_all_pl_positions_SERVER(,true)
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
					
				var accID = db_find_value(global.DB_SRV_TABLE_players, PLAYERS_ACCID_SERVER, PLAYERS_SOCKETID_SERVER, socketID_sender)
				if (accID == undefined)
					break
			
				with (instance) {
					var skill_index = data.index
					
					var playerSkill = undefined
					var playerSkillUpgrade = undefined
					var playerSkills = global.playerSkills_SERVER[? accID]
					var ds_width = ds_grid_width(playerSkills)
					var ds_height = ds_grid_height(playerSkills)
					for (var k = 0; k < ds_width; k++) {
						for (var z = 0; z < ds_height; z++) {
							var playerSkill = ds_grid_get(playerSkills, k, z)
							if (playerSkill != undefined and playerSkill.skill != undefined and playerSkill.skill.index == skill_index) {
								playerSkillUpgrade = playerSkill.skill.upgrade
								break
							}
						}
						if (playerSkillUpgrade != undefined)
							break
					}
					
					if (playerSkill == undefined or playerSkillUpgrade == undefined)
						break
					
					var isCancelled = false
					var foundI = undefined
					for (var i = 0; i < 5; i++)
						if (skills[i] != undefined and skills[i].index == skill_index) {
							foundI = i
							if (skills[i].casttime == undefined) {
								if (data.from != -1 and data.to != -1 and skills[data.from] != undefined and skills[data.to] != undefined) {
									var other_skill_index = skills[data.to].index
									
									var skillFrom_before = skills[data.from]
									var skillFromGlobal_before = global.playerSkillBoxes_SERVER[? accID][? data.from]
									
									skills[data.from] =
									{
										index: other_skill_index,
										cooldownmax: global.skill_cooldown_max_COMMON[other_skill_index],
										cooldown: global.skill_cooldown_max_COMMON[other_skill_index],
										code: global.skill_code_COMMON[other_skill_index],
										object: global.skill_object_SERVER[other_skill_index],
										casttimemax: global.skill_casttime_max_COMMON[other_skill_index],
										casttime: undefined,
										mana: global.skill_mana_COMMON[other_skill_index],
										energy: global.skill_energy_COMMON[other_skill_index],
										upgrade: playerSkillUpgrade
									}
									ds_map_set(global.playerSkillBoxes_SERVER[? accID], data.from,
									{
										index: skills[data.from].index,
										cooldownmax: skills[data.from].cooldownmax,
										cooldown: skills[data.from].cooldown,
										code: skills[data.from].code,
										object: skills[data.from].object,
										casttimemax: skills[data.from].casttimemax,
										casttime: skills[data.from].casttime,
										mana: skills[data.from].mana,
										energy: skills[data.from].energy,
										upgrade: playerSkillUpgrade
									})
									
									if (is_struct(skillFrom_before))
										delete skillFrom_before
									if (is_struct(skillFromGlobal_before))
										delete skillFromGlobal_before
								}
								else {
									if (is_struct(skills[i]))
										delete skills[i]
									skills[i] = undefined
									
									ds_map_delete(global.playerSkillBoxes_SERVER[? accID], i)
								}
							}
							else
								isCancelled = true
						}
						
					if (isCancelled)
						break
					
					if (data.to != -1) {
						// ? Duplication
						var skillTo_before = skills[data.to]
						var skillToGlobal_before = global.playerSkillBoxes_SERVER[? accID][? data.to]
									
						skills[data.to] =
						{
							index: skill_index,
							cooldownmax: global.skill_cooldown_max_COMMON[skill_index],
							cooldown: global.skill_cooldown_max_COMMON[skill_index],
							code: global.skill_code_COMMON[skill_index],
							object: global.skill_object_SERVER[skill_index],
							casttimemax: global.skill_casttime_max_COMMON[skill_index],
							casttime: undefined,
							mana: global.skill_mana_COMMON[skill_index],
							energy: global.skill_energy_COMMON[skill_index],
							upgrade: playerSkillUpgrade
						}
						ds_map_set(global.playerSkillBoxes_SERVER[? accID], data.to,
						{
							index: skills[data.to].index,
							cooldownmax: skills[data.to].cooldownmax,
							cooldown: skills[data.to].cooldown,
							code: skills[data.to].code,
							object: skills[data.to].object,
							casttimemax: skills[data.to].casttimemax,
							casttime: skills[data.to].casttime,
							mana: skills[data.to].mana,
							energy: skills[data.to].energy,
							upgrade: skills[data.to].upgrade,
						})
						
						if (is_struct(skillTo_before))
							delete skillFrom_before
						if (is_struct(skillToGlobal_before))
							delete skillFromGlobal_before
					}
					else {
						if (is_struct(skills[foundI]))
							delete skills[foundI]
						skills[foundI] = undefined
						
						ds_map_delete(global.playerSkillBoxes_SERVER[? accID], foundI)
					}
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_UPLOAD:
				var accountRow = db_get_row(global.DB_SRV_TABLE_accounts, data.accountID)
				if (accountRow != undefined and accountRow[? ACCOUNTS_PASSWORD_SERVER] != data.password)
					break
					
				if (data.accountID == "" or data.accountID == "Local" or data.password == "")
					break
					
				cleanup_player_ds_SERVER(data.accountID)
				
				// Uploaded Items
				if (data.items != pointer_null) {
					var boxes_TAKEN = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
					ds_grid_read(boxes_TAKEN, data.items)
					
					for (var i = 0; i < global.bc_hor_COMMON*global.pageCount_COMMON; i++) {
						for (var j = 0; j < global.bc_ver_COMMON+2; j++) {
							var _data = ds_grid_get(boxes_TAKEN, i, j)
						
							var _box = json_parse(_data)
							if (_box.item == pointer_null)
								_box.item = undefined
							else 
								_box.item = item_get_COMMON(_box.item.code, _box.item.upgrade)
							
							ds_grid_set(boxes_TAKEN, i, j, _box)
						}
					}
				
					global.playerBoxes_SERVER[? data.accountID] = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
					for (var i = 0; i < global.bc_hor_COMMON*global.pageCount_COMMON; i++) {
						for (var j = 0; j < global.bc_ver_COMMON+2; j++) {
							var box = ds_grid_get(boxes_TAKEN, i, j)
		
							ds_grid_set(global.playerBoxes_SERVER[? data.accountID], i, j, box)
						}
					}
					ds_grid_destroy(boxes_TAKEN)
				}
				
				// Uploaded Skill Tree
				if (data.skills != pointer_null) {
					var boxes_TAKEN = ds_grid_create(global.sc_hor_COMMON*global.pageCount_COMMON, global.sc_ver_COMMON)
					ds_grid_read(boxes_TAKEN, data.skills)
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
				
					global.playerSkills_SERVER[? data.accountID] = ds_grid_create(global.sc_hor_COMMON*global.pageCount_skill_COMMON, global.sc_ver_COMMON)
					for (var i = 0; i < global.sc_hor_COMMON*global.pageCount_COMMON; i++) {
						for (var j = 0; j < global.sc_ver_COMMON; j++) {
							var box = ds_grid_get(boxes_TAKEN, i, j)
		
							ds_grid_set(global.playerSkills_SERVER[? data.accountID], i, j, box)
						}
					}
					ds_grid_destroy(boxes_TAKEN)
				}
				
				// Uploaded Quests
				if (data.quests != pointer_null) {
					var quests_TAKEN = ds_map_create()
					ds_map_read(quests_TAKEN, data.quests)
					
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
				
					global.playerQuests_SERVER[? data.accountID] = ds_map_create()
					for (var i = 0; i < ds_size; i++) {
						var key = _quests_keys[i]
						var quest = ds_map_find_value(quests_TAKEN, key)
		
						ds_map_add(global.playerQuests_SERVER[? data.accountID], key, quest)
					}
					ds_map_destroy(quests_TAKEN)
				}
				
				// Uploaded Permanent Effect Boxes
				if (data.permanentEffectBoxes != pointer_null) {
					var permanentEffectBoxes = ds_list_create()
					ds_list_read(permanentEffectBoxes, data.permanentEffectBoxes)
					
					var ds_size = ds_list_size(data.permanentEffectBoxes)
					for (var i = 0; i < ds_size; i++) {
						var _data = ds_list_find_value(data.permanentEffectBoxes, i)
						
						var _permanentEffectBox = json_parse(_data)	
						if (_permanentEffectBox.creator == pointer_null)
							_permanentEffectBox.creator = undefined
							
						ds_list_set(permanentEffectBoxes, i, _permanentEffectBox)
					}
				
					global.playerPermanentEffectBoxes_SERVER[? data.accountID] = ds_list_create()
					for (var i = 0; i < ds_size; i++)				
						ds_list_add(global.playerPermanentEffectBoxes_SERVER[? data.accountID], ds_list_find_value(permanentEffectBoxes, i))
						
					ds_list_destroy(permanentEffectBoxes)
				}
				
				// Uploaded Skill Boxes
				if (data.skillBoxes != pointer_null) {
					var skillBoxes_TAKEN = ds_map_create()
					ds_map_read(skillBoxes_TAKEN, data.skillBoxes)
					
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
				
					global.playerSkillBoxes_SERVER[? data.accountID] = ds_map_create()
					for (var i = 0; i < ds_size; i++) {
						var key = _skillBoxes_keys[i]
						var skillBox = ds_map_find_value(skillBoxes_TAKEN, key)
		
						ds_map_add(global.playerSkillBoxes_SERVER[? data.accountID], key, skillBox)
					}
					delete _skillBoxes_keys
					ds_map_destroy(skillBoxes_TAKEN)
				}
				
				var accountinfoRow = db_get_row(global.DB_SRV_TABLE_accountinfo, data.accountID)
				if (accountinfoRow == undefined) {
					accountinfoRow = db_create_row(data.accountID)
					db_add_row(global.DB_SRV_TABLE_accountinfo, accountinfoRow)
				}
				
				if (data.gold != pointer_null)
					accountinfoRow[? ACCOUNTINFO_GOLD_SERVER] = data.gold
				if (data.level != pointer_null)
					accountinfoRow[? ACCOUNTINFO_LEVEL_SERVER] = data.level
				if (data.statPoints != pointer_null)
					accountinfoRow[? ACCOUNTINFO_STATPOINTS_SERVER] = data.statPoints
				if (data.skillPoints != pointer_null)
					accountinfoRow[? ACCOUNTINFO_SKILLPOINTS_SERVER] = data.skillPoints
				if (data.skillPoints != pointer_null)
					accountinfoRow[? ACCOUNTINFO_CLASS_SERVER] = data.class
				accountinfoRow[? ACCOUNTINFO_LOCATION_SERVER] = 1

				save_SERVER(data.accountID)
				
				show_messagebox(200, 200, "", "UPLOAD DONE", 1)
				
				if (data.autoLogin)
					_net_receive_packet(_CODE_LOGIN, json_stringify({ accountID: data.accountID, password: data.password }), socketID_sender)
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_KEYRELEASE:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				with (instance) {
					switch (data) {
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
			
			case _CODE_SAVE:
				var done = save_SERVER(socketID_sender)
				if (done) {
					var clientID = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_ACCID_SERVER)
					net_server_send(socketID_sender, CODE_DIALOGUE, json_stringify({ text: "[SAVED ON THE SERVER]: "+clientID, title: "", messageID: undefined, owner_assetName: undefined, ownerID: undefined, duration: 1, buttonsArray: undefined }), BUFFER_TYPE_STRING)
				}
				
				if (data == 1)
					_net_receive_packet(_CODE_UPLOAD_REQUEST, undefined, socketID_sender)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_UPLOAD_REQUEST:
				var clientID = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_ACCID_SERVER)
				var password = db_get_value_by_key(global.DB_SRV_TABLE_accounts, clientID, ACCOUNTS_PASSWORD_SERVER, socketID_sender)
				
				if (clientID != undefined)
					upload_COMMON(clientID, password, true, socketID_sender)
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
						var dir = point_direction(x, y, data.xx, data.yy)
						image_angle = dir
					
						change_energy(-15)
	
						attackSpeed_rem = 1/attackSpeed
						attackTimer = attackSpeed_rem*BASIC_ATTACK_TRIGGER_RATIO
						net_server_send(SOCKET_ID_ALL, CODE_BASIC_ATTACK, json_stringify({ socketID: socketID_sender, time: attackSpeed_rem }), BUFFER_TYPE_STRING)
					}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_CHAT:
				net_server_send(SOCKET_ID_ALL, CODE_CHAT, json_stringify(data), BUFFER_TYPE_STRING)
				break


			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_LOCATION:
				var playersRow = db_get_row(global.DB_SRV_TABLE_players, socketID_sender)
				var instance = playersRow[? PLAYERS_INSTANCE_SERVER]
				if (instance == undefined or !instance_exists(instance))
					break
				
				var accountID = playersRow[? PLAYERS_ACCID_SERVER]
				var locationID
				if (!data.set)
					locationID =  playersRow[? PLAYERS_LOCATION_SERVER] + (data.value == 1 ? 1 : -1)
				else
					locationID = data.value
				
				var location = ds_map_find_value(global.locations_SERVER, locationID)
				if (location != undefined) {
					var xx = location.spawn_x
					var yy = location.spawn_y
				
					with (instance) {
						if (data.xx == -1)
							x = xx
						else
							x = data.xx
							
						if (data.yy == -1)
							y = yy
						else
							y = data.yy
							
						lastPosition = undefined
						lastRotation = undefined
					}
			
					db_set_row_value(global.DB_SRV_TABLE_accountinfo, accountID, ACCOUNTINFO_LOCATION_SERVER, locationID)
					playersRow[? PLAYERS_LOCATION_SERVER] = locationID
					instance.location = locationID
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_SKILL0:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				var skill = cast_skill_SERVER(0, instance)
				if (skill != undefined)
					net_server_send(SOCKET_ID_ALL, CODE_SKILL0, socketID_sender, BUFFER_TYPE_INT32)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_BOX_CHANGE_ACTIVE:
				var box
				if (data.i != pointer_null)
					box = box_change_active_SERVER(socketID_sender, data.type, data.i, data.j, data.confirmation)
				else
					box = box_change_active_SERVER(socketID_sender, data.type, undefined, undefined, data.confirmation)
					
				if (box != -1) {
					if (data.i != pointer_null)
						net_server_send(socketID_sender, CODE_BOX_CHANGE_ACTIVE, json_stringify({ type: data.type, i: data.i, j: data.j, confirmation: data.confirmation }), BUFFER_TYPE_STRING) //
					else
						net_server_send(socketID_sender, CODE_BOX_CHANGE_ACTIVE, json_stringify({ type: data.type, i: undefined, j: undefined, confirmation: data.confirmation }), BUFFER_TYPE_STRING)
					
					var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
					if (instance == undefined or !instance_exists(instance))
						break
					
					var _box = box_get_active_SERVER(socketID_sender, ITEMTYPE_SWORD)
					var weaponSprite = _box.item == undefined ? sprite_get_name(sprNothingness) : sprite_get_name(_box.item.sprite)
	
					_box = box_get_active_SERVER(socketID_sender, ITEMTYPE_CLOTHES)
					var clothesSprite = _box.item == undefined ? sprite_get_name(sprNothingness) : sprite_get_name(_box.item.sprite)
					
					net_server_send(SOCKET_ID_ALL, CODE_APPEARENCE, json_stringify({ socketID: socketID_sender, weapon: weaponSprite, shoulders: clothesSprite }), BUFFER_TYPE_STRING)
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_GET_EFFECTBOXES:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				net_server_send(socketID_sender, CODE_GET_EFFECTBOXES, json_stringify({ socketID: socketID_sender, effectBoxes_str: json_write_effectBoxes_SERVER(instance.effectBoxes) }), BUFFER_TYPE_STRING)
			break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_UPGRADE_SKILL:
				var playersRow = db_get_row(global.DB_SRV_TABLE_players, socketID_sender)
				if (playersRow == undefined)
					break
				
				var accountID = playersRow[? PLAYERS_ACCID_SERVER]
				var accountinfoRow = db_get_row(global.DB_SRV_TABLE_accountinfo, accountID)
				if (accountinfoRow == undefined)
					break
					
				var skill = ds_grid_get(global.playerSkills_SERVER[? accountID], data.ii, data.jj)
				if (skill == undefined)
					break
						
				var skillBoxes = global.playerSkillBoxes_SERVER[? accountID]
				if (skillBoxes == undefined)
					break
						
				if (data.upgrade and accountinfoRow[? ACCOUNTINFO_SKILLPOINTS_SERVER] > 0) {
					accountinfoRow[? ACCOUNTINFO_SKILLPOINTS_SERVER]--
					skill.skill.upgrade++
					ds_grid_set(global.playerSkills_SERVER[? accountID], data.ii, data.jj, skill)
				}
				else if (!data.upgrade and skill.skill.upgrade > 0) {
					accountinfoRow[? ACCOUNTINFO_SKILLPOINTS_SERVER]++
					skill.skill.upgrade--
					ds_grid_set(global.playerSkills_SERVER[? accountID], data.ii, data.jj, skill)
				}
				else
					break
						
				var instance = playersRow[? PLAYERS_INSTANCE_SERVER]
						
				var _skillBoxes_keys = ds_map_keys_to_array(skillBoxes)
				var ds_size = array_length(_skillBoxes_keys)
				for (var i = 0; i < ds_size; i++) {
					var key = _skillBoxes_keys[i]
						
					var _skill = skillBoxes[? key]
					if (_skill.index == skill.skill.index) {
						skillBoxes[? key].upgrade = skill.skill.upgrade
							
						if (instance != undefined)
							with (instance)
								skills[key].upgrade = skill.skill.upgrade
						break
					}
				}
				delete _skillBoxes_keys
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_BUY:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				with (parNPC_SERVER) {
					if (real(id).npcID == data.npcID) {
						var isLoot = data.isLoot
						var boxes = isLoot == false ? real(id).boxes : real(id).lootBoxes
						
						var box = ds_grid_get(boxes, data.i, data.j)
						if (box.item != undefined and box.item.type == data.type) {
							item_setup_COMMON(box.item)
							if (box_get_confirmation_number_COMMON(box) == data.confirmation) {
								var price = isLoot ? 0 : box.tag.marketPrice
								if (instance.accountinfoRow[? ACCOUNTINFO_GOLD_SERVER] >= price) {
									var itemAdded_info
									if (data.target_i == pointer_null)
										itemAdded_info = item_add_SERVER(box, instance.accountinfoRow[? ACCOUNTINFO_ACCID_SERVER])
									else
										itemAdded_info = item_add_SERVER(box, instance.accountinfoRow[? ACCOUNTINFO_ACCID_SERVER], data.target_i, data.target_j)
										
									if (itemAdded_info.result) {
										var success = true
										if (isLoot)
											success = item_delete_COMMON(box, undefined, data.i, data.j, 1, boxes)
											
										if (success) {					
											if (!isLoot) {
												instance.accountinfoRow[? ACCOUNTINFO_GOLD_SERVER] -= price //
												net_server_send(socketID_sender, CODE_DIALOGUE, json_stringify({ text: "You have purchased "+item_get_title_COMMON(box.item)+".\n[c="+string(c_red)+"]-"+string(price)+"[/c] [img=sprCoin2]", title: "Purchase", messageID: undefined, owner_assetName: undefined, ownerID: undefined, duration: 1, buttonsArray: undefined }), BUFFER_TYPE_STRING)
											}
											
											net_server_send(socketID_sender, CODE_GET_INVENTORY, json_stringify({ boxes: json_write_boxes_SERVER(socketID_sender), gold: instance.accountinfoRow[? ACCOUNTINFO_GOLD_SERVER] }), BUFFER_TYPE_STRING)
										}
										else
											item_delete_COMMON(box, instance.accountinfoRow[? ACCOUNTINFO_ACCID_SERVER], itemAdded_info.i, itemAdded_info.j)
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
			
			case _CODE_SELL:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				var box = ds_grid_get(global.playerBoxes_SERVER[? instance.accountinfoRow[? ACCOUNTINFO_ACCID_SERVER]], data.i, data.j)
						
				if (box != undefined and box.item != undefined) {
					item_setup_COMMON(box.item)
					if (box_get_confirmation_number_COMMON(box) == data.confirmation) {
						var price = box.item.worth/2
						if (item_delete_COMMON(box, instance.accountinfoRow[? ACCOUNTINFO_ACCID_SERVER], data.i, data.j)) {
							instance.accountinfoRow[? ACCOUNTINFO_GOLD_SERVER] += price
									
							net_server_send(socketID_sender, CODE_GET_INVENTORY, json_stringify({ boxes: json_write_boxes_SERVER(socketID_sender), gold: instance.accountinfoRow[? ACCOUNTINFO_GOLD_SERVER] }), BUFFER_TYPE_STRING)
							net_server_send(socketID_sender, CODE_DIALOGUE, json_stringify({ text: "You have sold "+item_get_title_COMMON(box.item)+".\n[c="+string(c_ltlime)+"]"+string(price)+"[/c] [img=sprCoin2]", title: "Sell", messageID: undefined, owner_assetName: undefined, ownerID: undefined, duration: 1, buttonsArray: undefined }), BUFFER_TYPE_STRING)
						}
					}
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
	
			case _CODE_DIALOGUE:			
				var title = undefined
				var text = undefined
				var buttons = undefined
			
				switch (asset_get_index(data.owner_assetName)) {
					// contMain
					case contMain:
						switch (data.messageID) {
							// Message -1
							case 1:
								title = "Message"
								text = "You are given a cup of coffee.\nHow much gold do you want to tip?"
								buttons = json_stringify([ new st_dialogueButton("10", sprite_get_name(sprCoin), false, 10), new st_dialogueButton("20", sprite_get_name(sprCoin), false, 20),
														   new st_dialogueButton("30", sprite_get_name(sprCoin), false, 30), new st_dialogueButton("40", sprite_get_name(sprCoin), false, 40),
														   new st_dialogueButton("50", sprite_get_name(sprCoin), false, 50), new st_dialogueButton("60", sprite_get_name(sprCoin), false, 60),
														   new st_dialogueButton("70", sprite_get_name(sprCoin), false, 70), new st_dialogueButton("80", sprite_get_name(sprCoin), false, 80),
														   new st_dialogueButton("90", sprite_get_name(sprCoin), false, 90), new st_dialogueButton("100", sprite_get_name(sprCoin), false, 100) ])
								break
								
							case 2:
								title = "Message 2"
								text = "You are given a cup of coffee.\nHow much gold do you want to tip?"
								buttons = json_stringify([ new st_dialogueButton("10", sprite_get_name(sprCoin), false, 10), new st_dialogueButton("20", sprite_get_name(sprCoin), false, 20),
														   new st_dialogueButton("30", sprite_get_name(sprCoin), false, 30), new st_dialogueButton("40", sprite_get_name(sprCoin), false, 40),
														   new st_dialogueButton("50", sprite_get_name(sprCoin), false, 50), new st_dialogueButton("60", sprite_get_name(sprCoin), false, 60),
														   new st_dialogueButton("70", sprite_get_name(sprCoin), false, 70), new st_dialogueButton("80", sprite_get_name(sprCoin), false, 80),
														   new st_dialogueButton("90", sprite_get_name(sprCoin), false, 90), new st_dialogueButton("100", sprite_get_name(sprCoin), false, 100) ])
								break
						}
						break
				}
				
				if (title != undefined)
					net_server_send(socketID_sender, CODE_DIALOGUE, json_stringify({ text: text, title: title, messageID: data.messageID, owner_assetName: data.owner_assetName, ownerID: data.ownerID, duration: data.time, buttonsArray: buttons }), BUFFER_TYPE_STRING)
				else {
					var dialogueBoxes = dialogue_progress_SERVER(data.messageID, data.dialogueNo, data.owner_assetName, data.ownerID, data.answerBefore, socketID_sender)
					if (dialogueBoxes != [undefined, undefined])
						net_server_send(socketID_sender, CODE_DIALOGUE, json_stringify(dialogueBoxes), BUFFER_TYPE_STRING)
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_GET_INVENTORY:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				net_server_send(socketID_sender, CODE_GET_INVENTORY, json_stringify({ boxes: json_write_boxes_SERVER(socketID_sender), gold: instance.accountinfoRow[? ACCOUNTINFO_GOLD_SERVER] }), BUFFER_TYPE_STRING)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_GET_INVENTORY_SKILL:
				var accID = db_find_value(global.DB_SRV_TABLE_players, PLAYERS_ACCID_SERVER, PLAYERS_SOCKETID_SERVER, socketID_sender)
				if (accID == undefined)
					break
					
				var accountinfoRow = db_get_row(global.DB_SRV_TABLE_accountinfo, accID)
				if (accountinfoRow == undefined)
					break
				
				net_server_send(socketID_sender, CODE_GET_INVENTORY_SKILL, json_stringify({ grid: json_write_skillboxes_SERVER(socketID_sender), skillPoints: accountinfoRow[? ACCOUNTINFO_SKILLPOINTS_SERVER] }), BUFFER_TYPE_STRING)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_GET_STATISTICS:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				with (instance)
					net_server_send(socketID_sender, CODE_GET_STATISTICS, json_stringify({ socketID: socketID_sender, maxHp: maxHp, maxEnergy: maxEnergy, maxMana: maxMana, movementSpeed: movementSpeed, physicalPower: physicalPower, magicalPower: magicalPower, attackSpeed: attackSpeed }), BUFFER_TYPE_STRING)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_DROP_COIN:
				var coinCenter = instance_create(data.xx, data.yy, objCoinCenter_SERVER)
				coinCenter.value = 20
				net_server_send(SOCKET_ID_ALL, CODE_DROP_COIN, json_stringify({ coinID: coinCenter, xx: coinCenter.x, yy: coinCenter.y, value: coinCenter.value }), BUFFER_TYPE_STRING)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_BOX_CHANGE_POSITION:
				if (box_change_position_SERVER(socketID_sender, data.i, data.j, data.target_i, data.target_j))
					net_server_send(socketID_sender, CODE_BOX_CHANGE_POSITION, json_stringify({ i: data.i, j: data.j, target_i: data.target_i, target_j: data.target_j }), BUFFER_TYPE_STRING)
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_PING:
				net_server_send(socketID_sender, CODE_PING, data, BUFFER_TYPE_INT32, true)
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_SKILL1:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				instance.image_angle = data
				var arrow = cast_skill_SERVER(1, instance)
				if (arrow != undefined) {
					arrow.image_angle = data
					var pow = 1400
					arrow.spd = new st_speed(lengthdir_x(pow, data), lengthdir_y(pow, data))
				
					net_server_send(SOCKET_ID_ALL, CODE_SKILL1, json_stringify({ socketID: socketID_sender, xx: arrow.x, yy: arrow.y, angle: arrow.image_angle }), BUFFER_TYPE_STRING)
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_SKILL3:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				var skill = cast_skill_SERVER(3, instance)
				if (skill != undefined)
					net_server_send(SOCKET_ID_ALL, CODE_SKILL3, socketID_sender, BUFFER_TYPE_INT16)
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_SKILL2:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				instance.image_angle = data
				var laser = cast_skill_SERVER(2, instance)
				if (laser != undefined) {
					with (laser) {
						image_angle = instance.image_angle
						event_user(0)
					}
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
				
			case _CODE_GET_ACTIVE_QUESTS:
				tell_active_quests_SERVER(socketID_sender)
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_MOUSE_POSITION:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				with (instance) {
					var dir = point_direction(x, y, data.x, data.y)
					image_angle = dir
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
				
			case _CODE_DELETE_QUEST:
				var accountID = db_find_value(global.DB_SRV_TABLE_players, PLAYERS_ACCID_SERVER, PLAYERS_SOCKETID_SERVER, socketID_sender)
				if (accountID == undefined)
					break
					
				ds_map_delete(global.playerQuests_SERVER[? accountID], data) //
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case _CODE_KEYPRESS:
				var instance = db_get_value_by_key(global.DB_SRV_TABLE_players, socketID_sender, PLAYERS_INSTANCE_SERVER)
				if (instance == undefined or !instance_exists(instance))
					break
			
				with (instance) {
					switch (data) {
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
				var player = global.playerInstances[? bufferinfo]
				data = real(data)

				if (player != undefined) {
					player.xx = floor(data/100000)
					player.yy = data mod 100000
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_NPC_POSITION:
				var target = global.npcInstances[? bufferinfo]
				data = real(data)
				
				if (target != undefined) {
					target.xx = floor(data/100000)
					target.yy = data mod 100000
				}
				break
		
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_PLAYER_NAME:
				var player = global.playerInstances[? bufferinfo]
			
				ds_map_set(global.playerNames, bufferinfo, data)
				if (bufferinfo == global.socketID_player)
					global.clientName = data
				if (player != undefined)
					player.name = data
				break
		
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_PLAYER_HP:
				var player = global.playerInstances[? bufferinfo]
			
				if (player != undefined)
					player.hp = data
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_NPC_HP:
				var target = global.npcInstances[? bufferinfo]
			
				if (target != undefined)
					target.hp = data
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_PLAYER_MANA:
				var player = global.playerInstances[? bufferinfo]
			
				if (player != undefined)
					player.mana = data
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_NPC_MANA:
				var target = global.npcInstances[? bufferinfo]
			
				if (target != undefined)
					target.mana = data
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_PLAYER_MAXMANA:
				var player = global.playerInstances[? bufferinfo]
			
				if (player != undefined) {
					player.maxMana = data
					player.mana = min(player.maxMana, player.mana)
					player.manaBarP = player.mana/player.maxMana
				}
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_PLAYER_MAXENERGY:
				var player = global.playerInstances[? bufferinfo]
			
				if (player != undefined) {
					player.energy = data
					player.energy = min(player.maxEnergy, player.energy)
				}
				break

			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_NPC_ENERGY:
				var target = global.npcInstances[? bufferinfo]
			
				if (target != undefined)
					target.energy = data
				break
		
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_PLAYER_ROTATION:
				var player = global.playerInstances[? bufferinfo]
			
				if (player != undefined)
					player.image_angle_target = data
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_NPC_ROTATION:
				var target = global.npcInstances[? bufferinfo]
			
				if (target != undefined)
					target.image_angle_target = data
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_PLAYER_ENERGY:
				var player = global.playerInstances[? bufferinfo]
			
				if (player != undefined)
					player.energy = data
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_TELL_PLAYER_MAXHP:
				var player = global.playerInstances[? bufferinfo]
			
				if (player != undefined) {
					player.maxHp = data
					player.hp = min(player.maxHp, player.hp)
					player.healthBarP = player.hp/player.maxHp
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_PLACE_OBSTACLES:
				var obstacleCreator = instance_create(data.xx, data.yy, objObstacleCreator)
				with (obstacleCreator) {
					obstacleSprite = sprRockGrid
					image_xscale = data.xscale
					image_yscale = data.yscale
					image_angle = data.angle
				
					polygon = polygon_from_instance(id)
					event_user(0)
				}
				break
			
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_PLACE_LIGHTS:
				var light = instance_create(data.xx, data.yy, objLight)
				with (light) {
					Light_Range = data.range
					Light_Intensity = data.intensity
					Light_Color = data.color
					Light_Shadow_Length = data.shadow_length
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
			
				if (data.type == 1)
					tree = instance_create_layer(data.xx, data.yy, "Top", objTree)
				else if (data.type == 2)
					tree = instance_create_layer(data.xx, data.yy, "Top", objTree2)
				else if (data.type == 3)
					tree = instance_create_layer(data.xx, data.yy, "Top", objTree3)
				else if (data.type == 4)
					tree = instance_create_layer(data.xx, data.yy, "Top", objTree4)
			
				tree.image_angle = data.angle
				tree.image_xscale = data.xscale
				tree.image_yscale = data.yscale
				break
				
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			// // // // // // // // // // // // // // // // // // // // // // // //
			
			case CODE_PLACE_LAKES:
				var lake
			
				if (data.type == 1)
					lake = instance_create_layer(data.xx, data.yy, "Below", objLake)
				else if (data.type == 2)
					lake = instance_create_layer(data.xx, data.yy, "Below", objLake2)
			
				lake.image_angle = data.angle
				lake.image_xscale = data.xscale
				lake.image_yscale = data.yscale
				break
		}
		
		if (dataWillBeDeleted)
			delete data
	/*}
	catch (error) {
		global.networkErrors_count++
		show_debug_message(error)
	}*/
}