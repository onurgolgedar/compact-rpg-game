if (global.held_from_assetName == object_get_name(contDrawGUI))
	net_client_send(_CODE_SET_SKILLBOX, "undefined|"+string(global.held_box.index)+"|-1", BUFFER_TYPE_STRING)