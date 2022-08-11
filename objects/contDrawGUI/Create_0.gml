function answer(buttonIndex, qKey, value = undefined, xx = 250, yy = 250) {
	if (qKey == dialogue_get_qKey_COMMON(1, 1)) {
		switch (buttonIndex) {
			case 0:
				// ? SERVER SIDE
				/*var effectBox = ds_list_find_value(value.effectBox.owner.effectBoxes, value.order)
				if (effectBox != undefined and effectBox.level == value.effectBox.level and effectBox.code == value.effectBox.code)
					effectBox_destroy_SERVER(effectBox)*/
				break
		}
	}
}

mouseOnSkillBox = undefined
mouseOnMLogo = false
mouseOnSLogo = false
mouseOnCLogo = false
mouseOnBLogo = false
mouseOnQLogo = false
mouseOn_effectBox = undefined
guiWidth = undefined
guiHeight = undefined
isChatSelVisible = false
effectBox_textbox = undefined

windows = ds_list_create()

draw_set_circle_precision(18)
