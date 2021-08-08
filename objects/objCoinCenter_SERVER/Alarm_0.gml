if (collector == undefined) {
	with (objPlayer_SERVER) {
		if (point_distance(x, y, other.x, other.y) < 180) {
			other.collector = id
			
			var playerRow = db_get_row(global.DB_SRV_TABLE_accountInfo, accountID)
			playerRow[? ACCOUNTINFO_GOLD_SERVER] += other.value
			
			net_server_send(SOCKET_ID_ALL, CODE_COLLECT_COIN, string(socketID)+"|"+string(other.id)+"|"+string(playerRow[? ACCOUNTINFO_GOLD_SERVER]), BUFFER_TYPE_STRING)
			break
		}
	}

	alarm[0] = room_speed/3
}