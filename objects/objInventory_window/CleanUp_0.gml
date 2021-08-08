ds_grid_destroy(boxes)
if (boxFocused_textbox != undefined)
	instance_destroy(boxFocused_textbox)
	
if (!isRefreshing)
	with (objEquipments_window)
		instance_destroy()