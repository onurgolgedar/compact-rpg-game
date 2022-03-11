tell_all_healths_SERVER()
tell_all_manas_SERVER()
tell_all_energies_SERVER()


with (parNPC_SERVER) {
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_HP, json_stringify({ npcID: npcID, hp: hp }), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_MANA, json_stringify({ npcID: npcID, mana: mana }), BUFFER_TYPE_STRING, true)
	net_server_send(SOCKET_ID_ALL, CODE_TELL_NPC_ENERGY, json_stringify({ npcID: npcID, energy: energy }), BUFFER_TYPE_STRING, true)
}

alarm[1] = room_speed/10