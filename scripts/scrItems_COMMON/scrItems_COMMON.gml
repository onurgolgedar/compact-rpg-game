function Items_COMMON() {
	#macro ITEMTYPE_NECKLACE 0
	#macro ITEMTYPE_SWORD 1
	#macro ITEMTYPE_CLOTHES 2
	#macro ITEMTYPE_SHIELD 3
	#macro ITEMTYPE_MATTER 4
	#macro ITEMTYPE_VALUABLE 5
	
	#macro SWORD_000 0
	#macro SWORD_001 1
	#macro SWORD_002 2
	#macro SWORD_003 3
	#macro SWORD_000X 100
	#macro SWORD_001X 101
	#macro SWORD_002X 102
	#macro SWORD_003X 103

	#macro CLOTHES_000 500
	#macro CLOTHES_001 501
	#macro CLOTHES_002 502
	#macro CLOTHES_003 503
	#macro CLOTHES_000X 600
	#macro CLOTHES_001X 601
	#macro CLOTHES_002X 602
	#macro CLOTHES_003X 603
	
	#macro VALUABLE_000 3000
}

function item_get_COMMON(_code, upgrade = 0) {
	switch (_code) {
		case SWORD_000:
			return item_setup_COMMON(new st_sword_item("Wooden Sword", SWORD_000, sprSword_000, 5, 0, 0, 1, 10, upgrade))
		case SWORD_001:
			return item_setup_COMMON(new st_sword_item("Basic Sword", SWORD_001, sprSword_001, 7, 0, 15, 1.1, 30, upgrade))
		case SWORD_002:
			return item_setup_COMMON(new st_sword_item("Golden Sword", SWORD_002, sprSword_002, 10, 10, 0, 1.2, 100, upgrade))
		case SWORD_003:
			return item_setup_COMMON(new st_sword_item("Sword", SWORD_003, sprSword_003, 12, 0, 20, 1.2, 90, upgrade))
		case SWORD_000X:
			return item_setup_COMMON(new st_sword_item("Arena Sword: One", SWORD_000X, sprSword_012, 25, 0, 25, 1.8, 100, upgrade))
		case SWORD_001X:
			return item_setup_COMMON(new st_sword_item("Arena Sword: Two", SWORD_001X, sprSword_005, 15, 0, 50, 2.1, 100, upgrade))
		case SWORD_002X:
			return item_setup_COMMON(new st_sword_item("Arena Sword: Three", SWORD_002X, sprSword_025, 10, 10, 10, 1.7, 100, upgrade))
		case SWORD_003X:
			return item_setup_COMMON(new st_sword_item("Arena Sword: Four", SWORD_003X, sprSword_023, 10, 25, 0, 1.4, 100, upgrade))

		case CLOTHES_000:
			return item_setup_COMMON(new st_clothes_item("Basic Clothes", CLOTHES_000, sprClothes_000, 50, 0, 0, 10, upgrade))
		case CLOTHES_001:
			return item_setup_COMMON(new st_clothes_item("Clothes", CLOTHES_001, sprClothes_001, 70, 0, 5, 10, upgrade))
		case CLOTHES_002:
			return item_setup_COMMON(new st_clothes_item("Imperial Clothes", CLOTHES_002, sprClothes_002, 100, 0, 7, 10, upgrade))
		case CLOTHES_003:
			return item_setup_COMMON(new st_clothes_item("Knight's Clothes", CLOTHES_003, sprClothes_003, 120, 0, 10, 10, upgrade))
		case CLOTHES_000X:
			return item_setup_COMMON(new st_clothes_item("Arena Armor: One", CLOTHES_000X, sprClothes_006, 70, 20, 3, 100, upgrade))
		case CLOTHES_001X:
			return item_setup_COMMON(new st_clothes_item("Arena Armor: Two", CLOTHES_001X, sprClothes_005, 120, 45, 8, 100, upgrade))
		case CLOTHES_002X:
			return item_setup_COMMON(new st_clothes_item("Arena Armor: Three", CLOTHES_002X, sprClothes_013, 160, 0, 12, 100, upgrade))
		case CLOTHES_003X:
			return item_setup_COMMON(new st_clothes_item("Arena Armor: Four", CLOTHES_003X, sprClothes_017, 55, 25, 0, 100, upgrade))

		case VALUABLE_000:
			return item_setup_COMMON(new st_valuable_item("Silver", VALUABLE_000, sprValuable_000, 100, upgrade))
	}
}

function item_copy_COMMON(item) {
	switch (item.type) {
		case ITEMTYPE_SWORD:
			return new st_sword_item(item.name, item.code, item.sprite, item.physicalPower, item.magicalPower, item.criticalChance, item.attackSpeed, item.worth, item.upgrade)

		case ITEMTYPE_CLOTHES:
			return new st_clothes_item(item.name, item.code, item.sprite, item.maxHp, item.maxMana, item.slowRate, item.worth, item.upgrade)
			
		case ITEMTYPE_VALUABLE:
			return new st_valuable_item(item.name, item.code, item.sprite, item.worth, item.upgrade)
	}
}

function item_get_title_COMMON(item) {
	switch (item.type) {
		case ITEMTYPE_SWORD:
			return "[b]"+item.name+" (+"+string(item.upgrade)+")[/b]"
			
		case ITEMTYPE_CLOTHES:
			return "[b]"+item.name+" (+"+string(item.upgrade)+")[/b]"
			
		case ITEMTYPE_VALUABLE:
			return "[b]"+item.name+strret(" (+"+string(item.upgrade)+")", item.upgrade != 0)+"[/b]"
	}
	
	return ""
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
			
		case ITEMTYPE_VALUABLE:
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
	else if (item.type == ITEMTYPE_VALUABLE)
		return string(item.worth)+string(item.upgrade)
}

function item_delete_COMMON(box, accountID = undefined, box_i = undefined, box_j = undefined, count = 1, boxes = undefined, questAuthorization = false) {
	if (boxes == undefined)
		boxes = global.playerBoxes_SERVER[? accountID]
	
	var sameItem_box = item_get_exists_SERVER(box, accountID, boxes)

	if (!box.item.isCollectable or sameItem_box == undefined) {
		if (box_i == undefined) {
			for (var pageScanning = 1; pageScanning <= global.pageCount_COMMON; pageScanning++)
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

function st_sword_item (_name, _code, _sprite, _physicalPower, _magicalPower, _criticalChance, _attackSpeed, _worth, _upgrade) constructor
{
	name = _name
	code = _code
	type = ITEMTYPE_SWORD
	isCollectable = false
	sprite = _sprite
	physicalPower_base = _physicalPower
	magicalPower_base = _magicalPower
	criticalChance_base = _criticalChance
	attackSpeed_base = _attackSpeed
	upgrade = _upgrade
	worth_base = _worth
	
	physicalPower = undefined
	magicalPower = undefined
	criticalChance = undefined
	attackSpeed = undefined
	worth = undefined
}

function st_clothes_item (_name, _code, _sprite, _maxHp, _maxMana, _slowRate, _worth, _upgrade) constructor
{
	name = _name
	code = _code
	type = ITEMTYPE_CLOTHES
	isCollectable = false
	sprite = _sprite
	maxHp_base = _maxHp
	maxMana_base = _maxMana
	slowRate_base = _slowRate
	upgrade = _upgrade
	worth_base = _worth
	
	maxHp = undefined
	maxMana = undefined
	slowRate = undefined
	worth = undefined
}

function st_valuable_item (_name, _code, _sprite, _worth, _upgrade) constructor
{
	name = _name
	code = _code
	type = ITEMTYPE_VALUABLE
	isCollectable = true
	sprite = _sprite
	upgrade = _upgrade
	worth_base = _worth
	
	worth = undefined
}