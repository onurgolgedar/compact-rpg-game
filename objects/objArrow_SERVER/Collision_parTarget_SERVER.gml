if (real(other.id) != owner) {
	other.change_hp(-30*(100+10*skill.upgrade)/100)
	instance_destroy()
}