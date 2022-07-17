if (global.held_from_assetName == object_get_name(contDrawGUi))
	net_client_send(_CODE_SET_SKILLBOX, json_stringify({ from: undefined, index: global.held_box.index, to: -1 }), BUFFER_TYPE_STRING)