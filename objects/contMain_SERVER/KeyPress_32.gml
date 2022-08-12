if (keyboard_check(vk_control) and keyboard_check(vk_shift)) {
	if (global.drawEventEnabled) {
		instance_deactivate_object(contLightinginit_sight)
		instance_deactivate_object(objLight_sight)
		instance_deactivate_object(parLight_sight)
		instance_deactivate_object(contLightRenderer)
		instance_deactivate_object(objLight)

		draw_enable_drawevent(0)
		global.drawEventEnabled = false
		if (global.socketID_player != undefined) {
			var adminRow = db_get_row(global.DB_SRV_TABLE_players, global.socketID_player)
			var adminInstance = adminRow[? PLAYERS_INSTANCE_SERVER]
			if (adminInstance != undefined and instance_exists(adminInstance))
				adminInstance.change_hp(-adminInstance.maxHp)
			/*kick(global.socketID_player)
			global.socketID_player = undefined*/
		}
	}
	else {
		instance_activate_object(contLightinginit_sight)
		instance_activate_object(objLight_sight)
		instance_activate_object(parLight_sight)
		instance_activate_object(contLightRenderer)
		instance_activate_object(objLight)
		
		draw_enable_drawevent(1)
		global.drawEventEnabled = true
	}
}