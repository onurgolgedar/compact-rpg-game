tell_all_healths_SERVER()
tell_all_manas_SERVER()
tell_all_energies_SERVER()

with (parNPC_SERVER) {
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_HP, json_stringify({ i: npcID, v: round(hp) }), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_MANA, json_stringify({ i: npcID, v: round(mana) }), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_ENERGY, json_stringify({ i: npcID, v: round(energy) }), BUFFER_TYPE_STRING, true)
}

alarm[1] = room_speed/5