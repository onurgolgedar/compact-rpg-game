function function_call(_method, time, useDelta) {
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