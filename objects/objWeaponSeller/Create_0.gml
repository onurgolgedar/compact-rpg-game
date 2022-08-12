function answer(buttonIndex, qKey, value = undefined, xx = 250, yy = 250) {
	if (qKey == dialogue_get_qKey_COMMON(-1, 1)) {
		switch (buttonIndex) {
			case 0:
				break
		}
	}
}

event_inherited()
hair = sprHair_001
clothes = sprClothes_009

rigidbody_create(sprHumanisticShoulders,
				 sprHumanisticArm, 27,
				 sprHumanisticFrontArm, 25,
				 sprHumanisticHand, 42)
set_style(hair, clothes)

animSwingASword_style = 0

