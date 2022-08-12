if (owner != undefined and instance_exists(owner)) {
	with (owner)
		ds_list_delete(windows, ds_list_find_index(windows, real(other.id)))
}

if (!isRefreshing) {
	minDepth = 999

	with (parWindow) {
	    if (depth < other.depth)
	        depth += 2
        
	    if (real(id) != real(other.id) and depth < other.minDepth)
	        other.minDepth = depth
	}

	with (parWindow) {
	    if (depth == other.minDepth)
	        function_call_COMMON(bring_forward, 1, false)
	}
}