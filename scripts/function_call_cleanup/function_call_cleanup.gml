function function_call_cleanup() {
	ds_map_destroy(global.functionsTimed)
	ds_map_destroy(global.functionsTimed_delta)
}