if (alarm[0] == -1) {
	net_server_send(other.socketID, CODE_LOCATION, json_stringify({ set: true, value: locationID, xx: xx, yy: yy }), BUFFER_TYPE_STRING)
	alarm[0] = SEC
}