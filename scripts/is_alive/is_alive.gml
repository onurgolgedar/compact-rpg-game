function is_alive(socketID) {
	socketID = socketID == undefined ? global.socketID_player : socketID
			
	return global.playerInstances[? socketID] != undefined
}