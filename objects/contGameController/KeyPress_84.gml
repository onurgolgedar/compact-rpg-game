if (!global.chatActive)
	net_server_send(SOCKET_ID_ALL, CODE_DAMAGED, json_stringify({ targetID: global.socketID_player, value: 1 }), BUFFER_TYPE_STRING)