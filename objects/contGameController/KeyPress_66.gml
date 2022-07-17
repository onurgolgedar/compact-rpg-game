if (!instance_exists(objinventory_window)) {
	var inventory_window = instance_create_layer(100, 140, "Windows", objinventory_window)
	net_client_send(_CODE_GET_INVENTORY)
}
else
	instance_destroy(objinventory_window)