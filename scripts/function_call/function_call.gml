function function_call(_method, time, useDelta) {
	if (time == 0) {
		(method(id, _method))()
	}
	else {
		var data = {func: method(id, _method)}
		ds_map_add(useDelta ? global.functionsTimed_delta : global.functionsTimed, data, time)
	}
}