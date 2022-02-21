function npc_get_name_COMMON(owner) {
	switch (owner) {
		case contMain:
			return "General"
			
		case objWeaponSeller:
			return "Weapon Seller"
	}
	
	return object_get_name(owner.object_index)
}