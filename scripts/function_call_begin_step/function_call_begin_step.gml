function function_call_begin_step() {
	var functionsTimed_array = ds_map_keys_to_array(global.functionsTimed)
	var ds_size = array_length(functionsTimed_array)
	for (var i = 0; i < ds_size; i++) {
		var alarmValue = global.functionsTimed[? functionsTimed_array[i]]
	
		if (alarmValue-1 > 0)
			global.functionsTimed[? functionsTimed_array[i]] -= 1
		else {
			if (instance_exists(method_get_self(functionsTimed_array[i].func)))
				functionsTimed_array[i].func()
			ds_map_delete(global.functionsTimed, functionsTimed_array[i])
		}
	}

	var functionsTimed_delta_array = ds_map_keys_to_array(global.functionsTimed_delta)
	var ds_size = array_length(functionsTimed_delta_array)
	for (var i = 0; i < ds_size; i++) {
		var alarmValue_delta = global.functionsTimed_delta[? functionsTimed_delta_array[i]]
	
		if (alarmValue_delta-delta() > 0)
			global.functionsTimed_delta[? functionsTimed_delta_array[i]] -= delta()
		else {
			if (instance_exists(method_get_self(functionsTimed_delta_array[i].func)))
				functionsTimed_delta_array[i].func()
			ds_map_delete(global.functionsTimed_delta, functionsTimed_delta_array[i])
		}
	}
}