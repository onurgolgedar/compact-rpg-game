function is_mouse_on() {
	return point_distance(x, y, mouse_x, mouse_y) < 27
}

event_inherited()

windows = ds_list_create()