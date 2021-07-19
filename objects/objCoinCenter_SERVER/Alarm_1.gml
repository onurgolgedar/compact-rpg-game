if (collector == undefined) {
	with (objPlayer_SERVER) {
		if (point_distance(x, y, other.x, other.y) < 100) {
			other.collector = id
			net_server_send(SOCKET_ID_ALL, CODE_COLLECT_COIN, string(socketID)+"|"+string(other.id), BUFFER_TYPE_STRING)
			break
		}
	}

	alarm[1] = room_speed/3
}