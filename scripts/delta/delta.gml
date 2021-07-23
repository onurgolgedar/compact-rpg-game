function delta() {
	return clamp(delta_time/1000000, 1/240, 1/15)
}