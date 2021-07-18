if (!instance_exists(objInventory_window)) {
	var inventory_window = instance_create_layer(50, 50, "Windows", objInventory_window)
	net_client_send(_CODE_GET_BOXES)
}
else
	instance_destroy(objInventory_window)