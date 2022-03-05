#region FUNCTION DECLARATIONS
function change_hp(value) {	
	var beforeHp = hp
	
	if (hp+value < maxHp)
		hp += value
	else
		hp = maxHp
	
	if (hp <= 0) {
		hp = 0
		playerRow[? PLAYERS_DEATHTIMER_SERVER] = 2
		playerRow[? PLAYERS_X_SERVER] = -1
		playerRow[? PLAYERS_Y_SERVER] = -1
		instance_destroy()
		net_server_send(SOCKET_ID_ALL, CODE_KILL, targetID, BUFFER_TYPE_INT16)
	}
	
	playerRow[? PLAYERS_HP_SERVER] = hp
	
	var diff = hp-beforeHp
	if (diff < 0)
		net_server_send(SOCKET_ID_ALL, CODE_SLIDING_TEXT, json_stringify({ socketID: targetID, xx: 0, yy: -40, text: string(round(diff)), life: 0.7+abs(diff)/100*1.4, spd_x: irandom_range(250, 270)*choose(1, -1), spd_y: -420+random_range(-150, -250), color: c_red, size: 0.9+abs(diff)/100*1.4, maxlife: 0.7+abs(diff)/100*1.4 }), BUFFER_TYPE_STRING, true)
}

function change_energy(value) {
	if (energy+value < maxEnergy)
		energy += value
	else
		energy = maxEnergy
	
	playerRow[? PLAYERS_ENERGY_SERVER] = energy
}

function change_mana(value) {
	if (mana+value < maxMana)
		mana += value
	else
		mana = maxMana
	
	playerRow[? PLAYERS_MANA_SERVER] = mana
}
#endregion

event_inherited()

socketID = undefined
accountID = undefined
playerRow = undefined
accountInfoRow = undefined

class = undefined
skills = ds_map_create()

movementSpeed_base = 0
movementSpeed_add = 0
movementSpeed = 0 // movementSpeed_base+movementSpeed_add
key_a = false
key_s = false
key_d = false
key_w = false