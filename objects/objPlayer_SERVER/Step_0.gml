event_inherited()

var ds_size = array_length(skills)
for (var i = 0; i < ds_size; i++) {
	var skill = skills[i]
	if (skill != undefined) {
		if (skill.casttime != undefined) {
			if (skill.casttime+global.delta_COMMON < skill.casttimemax)
				skill.casttime += global.delta_COMMON
			else
				skill.casttime = skill.casttimemax
		}
	
		value = global.delta_COMMON*(1+0.2*(class == CLASS_ASSASSIN_SERVER))
		if (skill.cooldown-value > 0)
			skill.cooldown -= value
		else
			skill.cooldown = 0
	}
}

playerRow[? PLAYERS_HP_SERVER] = hp
playerRow[? PLAYERS_ENERGY_SERVER] = energy
playerRow[? PLAYERS_MANA_SERVER] = mana

// Movement Speed
var movspd_x = -key_a+key_d
var movspd_y = -key_w+key_s
if (abs(movspd_x)+abs(movspd_y) == 2) {
	movspd_x /= sqrt(2)
	movspd_y /= sqrt(2)
}
var r = 1+random(1)/2.5
movspd_x *= movementSpeed*r
movspd_y *= movementSpeed*r

var slowFactor = (1-(attackTimer != 0)/2)
movspd_x *= slowFactor
movspd_y *= slowFactor
	
x += movspd_x*global.delta_COMMON
y += movspd_y*global.delta_COMMON

spd_res.xx += movspd_x
spd_res.yy += movspd_y