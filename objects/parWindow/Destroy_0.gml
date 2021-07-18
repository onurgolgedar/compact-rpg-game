if (owner != undefined and instance_exists(owner)) {
	with (owner)
		ds_list_delete(windows, ds_list_find_index(windows, other.id))
}

minDepth = 999

with (parWindow) {
    if (depth < other.depth)
        depth += 2
        
    if (id != other.id and depth < other.minDepth)
        other.minDepth = depth
}

with (parWindow) {
    if (depth == other.minDepth)
        alarm[0] = 1
}