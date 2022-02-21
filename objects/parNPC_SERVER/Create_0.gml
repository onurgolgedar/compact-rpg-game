#region FUNCTION DECLARATIONS
function change_hp(value) {	
	var beforeHp = hp
	
	if (hp+value < maxHp)
		hp += value
	else
		hp = maxHp
	
	if (hp <= 0) {
		hp = 0
		instance_destroy()
		net_server_send(SOCKET_ID_ALL, CODE_KILL, targetID, BUFFER_TYPE_INT32)
	}
	
	var diff = hp-beforeHp
	if (diff < 0)
		net_server_send(SOCKET_ID_ALL, CODE_SLIDING_TEXT, string(targetID)+"|"+string(0)+"|"+string(-40)+"|"+string(round(diff))+"|"+string(0.7+abs(diff)/100*1.4)+"|"+string(irandom_range(250, 270)*choose(1, -1))+"|"+string(-420+random_range(-150, -250))+"|"+string(c_red)+"|"+string(0.9+abs(diff)/100*1.4), BUFFER_TYPE_STRING, true)
}

function change_energy(value) {
	if (energy+value < maxEnergy)
		energy += value
	else
		energy = maxEnergy
}

function change_mana(value) {
	if (mana+value < maxMana)
		mana += value
	else
		mana = maxMana
}

function choose_target() {
	function_call(choose_target, 0.1, true)
}
#endregion

event_inherited()

if (name == "" and clientObject != noone)
	name = npc_get_name_COMMON(clientObject)

npcID = x*10000+y
targetID = npcID

target = undefined
function_call(choose_target, 1, true)

visible = global.drawServer