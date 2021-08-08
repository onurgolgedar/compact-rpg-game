if (global.held_box != undefined) {
	if (global.held_from == object_get_name(objInventory_window) or global.held_from == object_get_name(objEquipments_window)) {
		draw_outline_origin(global.held_box.item.sprite, -1, global.dmx, global.dmy, 0.47, 0.47, 60, 1)
		draw_sprite_origin_ext(global.held_box.item.sprite, -1, global.dmx, global.dmy, 0.47, 0.47, 60, c_white, 1)
	}
	else if (global.held_from == object_get_name(objSkills_window))
		draw_sprite(global.held_box.skill.sprite, -1, global.dmx, global.dmy)
	else if (global.held_from == object_get_name(contDrawGUI))
		draw_sprite(global.held_box.sprite, -1, global.dmx, global.dmy)
}