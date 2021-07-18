function anim_end(instance) {
	var ae_obj = instance == undefined ? id : instance

	with (ae_obj) {
		if (animationController != undefined)
			return false
		
		if (rigidbodyParts == undefined)
			return true
	
		var ds_size = ds_list_size(rigidbodyParts)
		for (var i = 0; i < ds_size; i++) {
			with (ds_list_find_value(rigidbodyParts, i)) {
				if (animTarget != undefined)
					return false
			}
		}

		return true
	}

	return false
}