function get_skill_sprite(index) {
	switch (index) {
		case SKILL_0:
			return sprSkill0_symbol
		case SKILL_1:
			return sprSkill1_symbol
		case SKILL_2:
			return sprSkill2_symbol
		case SKILL_3:
			return sprSkill3_symbol
		default:
			return sprNothingness
	}
}