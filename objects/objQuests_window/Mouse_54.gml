if (is_mouse_on() and !is_click_blocked()) {	
	if (mouseOnButton >= 100) {
		var questIndex =  mouseOnButton-100
		var questKey = ds_map_keys_to_array(global.activeQuests_player)[questIndex]
		if (global.activeQuests_player[? questKey].isDeletable) {
			net_client_send(_CODE_DELETE_QUEST, global.activeQuests_player[? questKey].code, BUFFER_TYPE_INT32)
			ds_map_delete(global.activeQuests_player, questKey)
			prepDone = false
			event_perform(ev_alarm, 0)
		}
	}
}