if (owner != undefined) {
	var index = ds_list_find_index(owner.windows, id)
	if (index != -1)
		ds_list_delete(owner.windows, index)
}