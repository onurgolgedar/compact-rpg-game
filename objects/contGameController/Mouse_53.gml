if (!is_alive())
	exit

if (get_active_item(ITEMTYPE_SWORD) != undefined)
	net_client_send(_CODE_LEFT_CLICK, string(mouse_x)+"|"+string(mouse_y), BUFFER_TYPE_STRING)