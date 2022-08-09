function main_loop_t() {
	onWater = !place_empty(x, y, parLake_SERVER)
	
	var ds_size = ds_list_size(effectBoxes)
	for (var i = 0; i < ds_size; i++) {
		var effectBox = effectBoxes[| i]
		
		if (effectBox.maxTime != -1) {
			var decrease = 1/5
		    if (effectBox.time-decrease > 0)
		        effectBox.time -= decrease
		    else if (!effectBox.isStackable or effectBox.directDestroy) {
				if (effectBox_destroy_SERVER(effectBox)) {
					i--
					ds_size--
				}
				continue
			}
		    else {
		        effectBox.stackCount -= 1
				effectBox_destroy_SERVER(effectBox)
		        effectBox.time = effectBox.maxTime
		    }
		}

		if (effectBox.isStackable and effectBox.stackCount == 0) {
			if (effectBox_destroy_SERVER(effectBox)) {
				i--
				ds_size--
			}
			continue
		}
	}

	function_call_COMMON(main_loop_t, 1/5, true)
}
function_call_COMMON(main_loop_t, 1/5, true)

targetID = undefined
level = 1

attackTimer = 0
attackSpeed_rem = attackSpeed

effectBoxes = ds_list_create()

hp = maxHp
mana = maxMana
energy = maxEnergy

onWater = false

visible = global.drawServer

event_inherited()