function effectBox_destroy_SERVER(effectBox, trigger = true) {
	if (!instance_exists(effectBox.owner))
		return false
		
	var pos = ds_list_find_index(effectBox.owner.effectBoxes, effectBox)
	if (pos == -1)
		return false
	
	if (trigger)
		switch (effectBox.code) {
			case EFFECTBOX_BUFF_1:

				break
				
			case EFFECTBOX_PERMANENT_BUFF_1:

				break
		}
	
	ds_list_delete(effectBox.owner.effectBoxes, pos)
	if (effectBox.owner.object_index == objPlayer and effectBox.isPermanent) {
		var globalEffectBoxes = global.playerPermanentEffectBoxes[? accountID]
		pos = ds_list_find_index(globalEffectBoxes, effectBox)
		ds_list_delete(globalEffectBoxes, effectBox)
	}
		
	return true
}

function effectBox_created_SERVER(_effectBox) {
	switch (_effectBox.code) {
		case EFFECTBOX_BUFF_1:

			break
			
		case EFFECTBOX_PERMANENT_BUFF_1:

			break
	}
}

function effectBox_create_SERVER(code, owner, creator) {
	var effectBox = undefined
	switch (code) {
		case EFFECTBOX_BUFF_1:
			effectBox = new effectBox(code, "Buff 1", owner, creator,, 5,,,,, true, 1, 2, "This is a test.", sprite_get_name(sprMainBS))
			break
			
		case EFFECTBOX_PERMANENT_BUFF_1:
			effectBox = new effectBox(code, "Permanent Buff 1", owner, creator,, 100,,,true,, true, 1, 2, "This is a permanent test.", sprite_get_name(sprMainBS))
			break
	}
	
	return effectBox
}

function effectBox_add_SERVER(code, owner, creator) {
	var effectBox = effectBox_create_SERVER(code, owner, creator)
	if (effectBox == undefined)
		return undefined
	
	with (owner) {
		existingEffectBox = false
		for (var i = 0; i < ds_size; i++) {
			var _effectBox = effectBoxes[| i]
					
			if (_effectBox.code == code and _effectBox.level == effectBox.level and !effectBox.seperate)
				existingEffectBox = _effectBox
		}
				
		if (existingEffectBox == false) {
			ds_list_add(effectBoxes, effectBox)
			if (object_index == objPlayer_SERVER and effectBox.isPermanent)
				ds_list_add(global.playerPermanentEffectBoxes[? accountID], effectBox)
		}
		else {
			existingEffectBox.time =  max(existingEffectBox.maxTime, effectBox.maxTime)
		    if (existingEffectBox.isStackable and existingEffectBox.stackCount < existingEffectBox.maxStackCount)
		        existingEffectBox.stack += 1
		}
	}
			
	effectBox_created_SERVER(effectBox)
}
