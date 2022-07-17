if (global.held_box != undefined) {
	if (global.held_from_assetName == object_get_name(objinventory_window) or global.held_from_assetName == object_get_name(objEquipments_window) or global.held_from_assetName == object_get_name(objTrade_window) or global.held_from_assetName == object_get_name(objLoot_window)) {
		draw_outline_origin(global.held_box.item.sprite, -1, global.dmx, global.dmy, 0.47, 0.47, 60, 1)
		draw_sprite_origin_ext(global.held_box.item.sprite, -1, global.dmx, global.dmy, 0.47, 0.47, 60, c_white, 1)
	}
	else if (global.held_from_assetName == object_get_name(objSkills_window))
		draw_sprite(global.held_box.skill.sprite, -1, global.dmx, global.dmy)
	else if (global.held_from_assetName == object_get_name(contDrawGUi))
		draw_sprite(global.held_box.sprite, -1, global.dmx, global.dmy)
}