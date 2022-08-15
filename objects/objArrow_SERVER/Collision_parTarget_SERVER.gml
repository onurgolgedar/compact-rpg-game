if (real(other.id) != owner) {
	other.change_hp(get_damage())
	instance_destroy()
}