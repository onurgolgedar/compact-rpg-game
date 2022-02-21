if (!instance_exists(objInventory_window)) {
	var inventory_window = instance_create_layer(100, 140, "Windows", objInventory_window)
	net_client_send(_CODE_GET_INVENTORY)
}
else
	instance_destroy(objInventory_window)