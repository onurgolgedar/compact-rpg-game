function Items_COMMON() {
	#macro ITEMTYPE_NECKLACE 0
	#macro ITEMTYPE_SWORD 1
	#macro ITEMTYPE_CLOTHES 2
	#macro ITEMTYPE_SHIELD 3
	#macro ITEMTYPE_MATTER 4
	#macro ITEMTYPE_PRECIOUS 5
	
	#macro SWORD_000 0
	#macro SWORD_001 1
	#macro SWORD_002 2
	#macro SWORD_003 3

	#macro CLOTHES_000 500
	#macro CLOTHES_001 501
	#macro CLOTHES_002 502
	#macro CLOTHES_003 503
	
	#macro PRECIOUS_000 3000
}

function item_get_COMMON(_code, upgrade = 0) {
	switch (_code) {
		case SWORD_000:
			return item_setup_COMMON({ name: "Sword 1", code: SWORD_000, type: ITEMTYPE_SWORD, isCollectable: false, physicalPower_base: 7, magicalPower_base: 17, criticalChance_base: 0, attackSpeed_base: 1.2, worth_base: 200, sprite: sprSword_045, physicalPower: undefined, magicalPower: undefined, criticalChance: undefined, attackSpeed: undefined, worth: undefined, upgrade: upgrade, marketPrice: undefined })
		case SWORD_001:
			return item_setup_COMMON({ name: "Sword 2", code: SWORD_001, type: ITEMTYPE_SWORD, isCollectable: false, physicalPower_base: 13, magicalPower_base: 11, criticalChance_base: 0, attackSpeed_base: 1.1, worth_base: 200, sprite: sprSword_021, physicalPower: undefined, magicalPower: undefined, criticalChance: undefined, attackSpeed: undefined, worth: undefined, upgrade: upgrade, marketPrice: undefined })
		case SWORD_002:
			return item_setup_COMMON({ name: "Sword 3", code: SWORD_002, type: ITEMTYPE_SWORD, isCollectable: false, physicalPower_base: 18, magicalPower_base: 7, criticalChance_base: 0, attackSpeed_base: 1.4, worth_base: 200, sprite: sprSword_005, physicalPower: undefined, magicalPower: undefined, criticalChance: undefined, attackSpeed: undefined, worth: undefined, upgrade: upgrade, marketPrice: undefined })
		case SWORD_003:
			return item_setup_COMMON({ name: "Sword 4", code: SWORD_003, type: ITEMTYPE_SWORD, isCollectable: false, physicalPower_base: 21, magicalPower_base: 0, criticalChance_base: 0, attackSpeed_base: 1.4, worth_base: 200, sprite: sprSword_046, physicalPower: undefined, magicalPower: undefined, criticalChance: undefined, attackSpeed: undefined, worth: undefined, upgrade: upgrade, marketPrice: undefined })

		case CLOTHES_000:
			return item_setup_COMMON({ name: "Clothes 1", code: CLOTHES_000, type: ITEMTYPE_CLOTHES, isCollectable: false, maxHp_base: 0, maxMana_base: 40, slowRate_base: 0, worth_base: 400, sprite: sprClothes_010, maxHp: undefined, maxMana: undefined, slowRate: undefined, worth: undefined, upgrade: upgrade, marketPrice: undefined })
		case CLOTHES_001:
			return item_setup_COMMON({ name: "Clothes 2", code: CLOTHES_001, type: ITEMTYPE_CLOTHES, isCollectable: false, maxHp_base: 30, maxMana_base: 15, slowRate_base: 0, worth_base: 400, sprite: sprClothes_009, maxHp: undefined, maxMana: undefined, slowRate: undefined, worth: undefined, upgrade: upgrade, marketPrice: undefined })
		case CLOTHES_002:
			return item_setup_COMMON({ name: "Clothes 3", code: CLOTHES_002, type: ITEMTYPE_CLOTHES, isCollectable: false, maxHp_base: 60, maxMana_base: 0, slowRate_base: 10, worth_base: 400, sprite: sprClothes_020, maxHp: undefined, maxMana: undefined, slowRate: undefined, worth: undefined, upgrade: upgrade, marketPrice: undefined })
		case CLOTHES_003:
			return item_setup_COMMON({ name: "Clothes 4", code: CLOTHES_003, type: ITEMTYPE_CLOTHES, isCollectable: false, maxHp_base: 90, maxMana_base: 0, slowRate_base: 20, worth_base: 400, sprite: sprClothes_007, maxHp: undefined, maxMana: undefined, slowRate: undefined, worth: undefined, upgrade: upgrade, marketPrice: undefined })

		case PRECIOUS_000:
			return item_setup_COMMON({ name: "Silver", code: PRECIOUS_000, type: ITEMTYPE_PRECIOUS, isCollectable: true, worth_base: 50, sprite: sprSilver, worth: undefined, upgrade: 0, marketPrice: undefined })
	}
}

function item_copy_COMMON(item) {
	switch (item.type) {
		case ITEMTYPE_SWORD:
			return { name: item.name, code: item.code, type: item.type, isCollectable: item.isCollectable, physicalPower_base: item.physicalPower_base, magicalPower_base: item.magicalPower_base, criticalChance_base: item.criticalChance_base, attackSpeed_base: item.attackSpeed_base, worth_base: item.worth_base, sprite: item.sprite, physicalPower: item.physicalPower, magicalPower: item.magicalPower, criticalChance: item.criticalChance, attackSpeed: item.attackSpeed, worth: item.worth, upgrade: item.upgrade, marketPrice: undefined}

		case ITEMTYPE_CLOTHES:
			return { name: item.name, code: item.code, type: item.type, isCollectable: item.isCollectable, maxHp_base: item.maxHp_base, maxMana_base: item.maxMana_base, slowRate_base: item.slowRate_base, worth_base: item.worth_base, sprite: item.sprite, maxHp: item.maxHp, maxMana: item.maxMana, slowRate: item.slowRate, worth: item.worth, upgrade: item.upgrade, marketPrice: undefined }
			
		case ITEMTYPE_PRECIOUS:
			return { name: item.name, code: item.code, type: item.type, isCollectable: item.isCollectable, worth_base: item.worth_base, sprite: item.sprite, worth: item.worth, upgrade: item.upgrade, marketPrice: undefined }
	}
}

function item_get_title_COMMON(item) {
	switch (item.type) {
		case ITEMTYPE_SWORD:
			return "[b]"+item.name+" (+"+string(item.upgrade)+")[/b]"
			
		case ITEMTYPE_CLOTHES:
			return "[b]"+item.name+" (+"+string(item.upgrade)+")[/b]"
			
		case ITEMTYPE_PRECIOUS:
			return "[b]"+item.name+strret(" (+"+string(item.upgrade)+")", item.upgrade != 0)+"[/b]"
	}
	
	return ""
}

function box_create_COMMON(item = undefined, isForQuest = false, count = 1) {
	if (item == undefined)
		return  {item: global.boxEmpty_COMMON.item, tag: { isActive: global.boxEmpty_COMMON.tag.isActive, isForQuest: global.boxEmpty_COMMON.tag.isForQuest }, count: global.boxEmpty_COMMON.count}
	else
		return {item: item_copy_COMMON(item), tag: {isActive: false, isForQuest: isForQuest}, count: count}
}

function box_get_confirmation_number_COMMON(box) {
	if (box == undefined)
		return "--"
	else
		return string(box.tag.isActive)+string(box.tag.isForQuest)+string(item_get_confirmation_number_COMMON(box.item))
}

function item_setup_COMMON(item, upgrade = undefined) {
	if (upgrade != undefined)
		item.upgrade = upgrade
		
	switch (item.type) {
		case ITEMTYPE_SWORD:
			item.physicalPower = item.physicalPower_base
			item.magicalPower = item.magicalPower_base
			item.attackSpeed = item.attackSpeed_base
			item.criticalChance = item.criticalChance_base
			item.worth = item.worth_base
			break
		
		case ITEMTYPE_CLOTHES:
			item.maxHp = item.maxHp_base
			item.maxMana = item.maxMana_base
			item.slowRate = item.slowRate_base
			item.worth = item.worth_base
			break
			
		case ITEMTYPE_PRECIOUS:
			item.worth = item.worth_base
			break
	}
	
	return item
}

function item_get_confirmation_number_COMMON(item) {
	if (item == undefined)
		return "-"
	else if (item.type == ITEMTYPE_SWORD)
		return string(item.physicalPower)+string(item.magicalPower)+string(item.attackSpeed)+string(item.criticalChance)+string(item.worth)+string(item.upgrade)
	else if (item.type == ITEMTYPE_CLOTHES)
		return string(item.maxHp)+string(item.maxMana)+string(item.slowRate)+string(item.worth)+string(item.upgrade)
	else if (item.type == ITEMTYPE_PRECIOUS)
		return string(item.worth)+string(item.upgrade)
}

function item_delete_COMMON(box, accountID = undefined, box_i = undefined, box_j = undefined, count = 1, boxes = undefined, questAuthorization = false) {
	if (boxes == undefined)
		boxes = global.playerBoxes[? accountID]
	
	var pageScanning = 1
	var sameItem_box = item_get_exists_SERVER(box, accountID, boxes)

	if (!box.item.isCollectable or sameItem_box == undefined) {
		if (box_i == undefined) {
		    for (var j = 0; j < global.bc_ver_COMMON; j++) {
		        for (var i = global.bc_hor_COMMON*(pageScanning-1); i < global.bc_hor_COMMON*pageScanning; i++) {
					var _box = ds_grid_get(boxes, i, j)
					if (item_get_confirmation_number_COMMON(_box.item) == item_get_confirmation_number_COMMON(box.item) and (!_box.tag.isForQuest or questAuthorization)) {
						ds_grid_set(boxes, i, j, box_create_COMMON())
						return true
					}
				}
			}
		}
		else {
			if (!ds_grid_get(boxes, box_i, box_j).tag.isForQuest or questAuthorization) {
				ds_grid_set(boxes, box_i, box_j, box_create_COMMON())
				return true
			}
		}
	}
	else if (sameItem_box != undefined) {
		var _box = ds_grid_get(boxes, sameItem_box.i, sameItem_box.j)
		if (!_box.tag.isForQuest or questAuthorization) {
			_box.count -= count
		
			if (box.count <= 0)
				ds_grid_set(boxes, sameItem_box.i, sameItem_box.j, box_create_COMMON())
		
			return true
		}
	}
	
	return false
}