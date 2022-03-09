if (!instance_exists(objConnection_window))
	instance_create_layer(615, 140, "Windows", objConnection_window)
else
	instance_destroy(objConnection_window)