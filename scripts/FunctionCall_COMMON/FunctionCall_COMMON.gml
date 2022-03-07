function function_call_COMMON(_method, time, useDelta) {
	if (time == 0) {
		(method(id, _method))()
	}
	else {
		var data = {func: method(id, _method)}
		var ds = useDelta ? global.functionsTimed_delta : global.functionsTimed
		if (ds_exists(ds, ds_type_map))
			ds_map_add(ds, data, time)
	}
}

function function_call_begin_step_COMMON() {
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

function function_call_cleanup_COMMON() {
	ds_map_destroy(global.functionsTimed)
	ds_map_destroy(global.functionsTimed_delta)
}

function function_call_init_COMMON() {
	global.functionsTimed = ds_map_create()
	global.functionsTimed_delta = ds_map_create()
}