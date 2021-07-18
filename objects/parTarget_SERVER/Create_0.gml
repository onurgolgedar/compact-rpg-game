function main_loop_t() {
	onWater = !place_empty(x, y, parLake_SERVER)

	function_call(main_loop_t, 1/5, true)
}
function_call(main_loop_t, 1/5, true)

targetID = undefined

attackTimer = 0
attackSpeed_rem = attackSpeed

spds = ds_map_create()
spd = {xx: 0, yy: 0}
spd_res = {xx: 0, yy: 0}

hp = maxHp
mana = maxMana
energy = maxEnergy

onWater = false

visible = global.drawServer