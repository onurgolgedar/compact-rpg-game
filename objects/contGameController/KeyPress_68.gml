if (!is_alive() or objPlayer.stunned)
	exit
	
net_client_send(_CODE_KEYPRESS, 4, BUFFER_TYPE_BYTE)