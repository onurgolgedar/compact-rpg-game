function item_get_COMMON(_code) {
	switch (_code) {
		case SWORD_000:
			return {name: "Sword 1", code: SWORD_000, type: ITEMTYPE_SWORD, isCollectable: false, physicalPower_base: 7, magicalPower_base: 17, criticalChance_base: 0, attackSpeed_base: 1.2, worth_base: 200, sprite: sprSword_045, physicalPower: undefined, magicalPower: undefined, criticalChance: undefined, attackSpeed: undefined, worth: undefined, upgrade: 0, marketPrice: undefined}
		case SWORD_001:
			return {name: "Sword 2", code: SWORD_001, type: ITEMTYPE_SWORD, isCollectable: false, physicalPower_base: 13, magicalPower_base: 11, criticalChance_base: 0, attackSpeed_base: 1.1, worth_base: 200, sprite: sprSword_021, physicalPower: undefined, magicalPower: undefined, criticalChance: undefined, attackSpeed: undefined, worth: undefined, upgrade: 0, marketPrice: undefined}
		case SWORD_002:
			return {name: "Sword 3", code: SWORD_002, type: ITEMTYPE_SWORD, isCollectable: false, physicalPower_base: 18, magicalPower_base: 7, criticalChance_base: 0, attackSpeed_base: 1.4, worth_base: 200, sprite: sprSword_005, physicalPower: undefined, magicalPower: undefined, criticalChance: undefined, attackSpeed: undefined, worth: undefined, upgrade: 0, marketPrice: undefined}
		case SWORD_003:
			return {name: "Sword 4", code: SWORD_003, type: ITEMTYPE_SWORD, isCollectable: false, physicalPower_base: 21, magicalPower_base: 0, criticalChance_base: 0, attackSpeed_base: 1.4, worth_base: 200, sprite: sprSword_046, physicalPower: undefined, magicalPower: undefined, criticalChance: undefined, attackSpeed: undefined, worth: undefined, upgrade: 0, marketPrice: undefined}

		case CLOTHES_000:
			return {name: "Clothes 1", code: CLOTHES_000, type: ITEMTYPE_CLOTHES, isCollectable: false, maxHp_base: 0, maxMana_base: 40, slowRate_base: 0, worth_base: 400, sprite: sprClothes_010, maxHp: undefined, maxMana: undefined, slowRate: undefined, worth: undefined, upgrade: 0, marketPrice: undefined}
		case CLOTHES_001:
			return {name: "Clothes 2", code: CLOTHES_001, type: ITEMTYPE_CLOTHES, isCollectable: false, maxHp_base: 30, maxMana_base: 15, slowRate_base: 0, worth_base: 400, sprite: sprClothes_009, maxHp: undefined, maxMana: undefined, slowRate: undefined, worth: undefined, upgrade: 0, marketPrice: undefined}
		case CLOTHES_002:
			return {name: "Clothes 3", code: CLOTHES_002, type: ITEMTYPE_CLOTHES, isCollectable: false, maxHp_base: 60, maxMana_base: 0, slowRate_base: 10, worth_base: 400, sprite: sprClothes_020, maxHp: undefined, maxMana: undefined, slowRate: undefined, worth: undefined, upgrade: 0, marketPrice: undefined}
		case CLOTHES_003:
			return {name: "Clothes 4", code: CLOTHES_003, type: ITEMTYPE_CLOTHES, isCollectable: false, maxHp_base: 90, maxMana_base: 0, slowRate_base: 20, worth_base: 400, sprite: sprClothes_007, maxHp: undefined, maxMana: undefined, slowRate: undefined, worth: undefined, upgrade: 0, marketPrice: undefined}
	}
}

function item_copy_COMMON(item) {
	switch (item.type) {
		case ITEMTYPE_SWORD:
			return { name: item.name, code: item.code, type: item.type, isCollectable: item.isCollectable, physicalPower_base: item.physicalPower_base, magicalPower_base: item.magicalPower_base, criticalChance_base: item.criticalChance_base, attackSpeed_base: item.attackSpeed_base, worth_base: item.worth_base, sprite: item.sprite, physicalPower: item.physicalPower, magicalPower: item.magicalPower, criticalChance: item.criticalChance, attackSpeed: item.attackSpeed, worth: item.worth, upgrade: item.upgrade, marketPrice: undefined}

		case ITEMTYPE_CLOTHES:
			return { name: item.name, code: item.code, type: item.type, isCollectable: item.isCollectable, maxHp_base: item.maxHp_base, maxMana_base: item.maxMana_base, slowRate_base: item.slowRate_base, worth_base: item.worth_base, sprite: item.sprite, maxHp: item.maxHp, maxMana: item.maxMana, slowRate: item.slowRate, worth: item.worth, upgrade: item.upgrade, marketPrice: undefined }
	}
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
		return string(box.tag.isActive)+string(box.tag.isForQuest)+string(box.count)+string(item_get_confirmation_number_COMMON(box.item))
}

function item_get_confirmation_number_COMMON(item) {
	if (item == undefined)
		return "-"
	else if (item.type == ITEMTYPE_SWORD)
		return string(item.physicalPower)+string(item.magicalPower)+string(item.attackSpeed)+string(item.criticalChance)+string(item.worth)
	else if (item.type == ITEMTYPE_CLOTHES)
		return string(item.maxHp)+string(item.maxMana)+string(item.slowRate)+string(item.worth)
}

function item_setup_COMMON(item) {
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
	}
}

function Items_COMMON() {
	#macro ITEMTYPE_NECKLACE 0
	#macro ITEMTYPE_SWORD 1
	#macro ITEMTYPE_CLOTHES 2
	#macro ITEMTYPE_SHIELD 3
	#macro ITEMTYPE_MATTER 4
	
	#macro SWORD_000 0
	#macro SWORD_001 1
	#macro SWORD_002 2
	#macro SWORD_003 3

	#macro CLOTHES_000 500
	#macro CLOTHES_001 501
	#macro CLOTHES_002 502
	#macro CLOTHES_003 503
}