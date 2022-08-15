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
		net_server_send(SOCKET_ID_ALL, CODE_SLIDING_TEXT, json_stringify({ socketID: targetID, xx: 0, yy: -40, text: string(round(diff)), life: 0.7+abs(diff)/100*1.4, spd_x: irandom_range(250, 270)*choose(1, -1), spd_y: -420+random_range(-150, -250), color: c_red, size: 0.9+abs(diff)/100*1.4, maxlife: 0.7+abs(diff)/100*1.4 }), BUFFER_TYPE_STRING, true)
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
	function_call_COMMON(choose_target, 0.1, true)
}
#endregion

event_inherited()

if (name == "" and clientObject != noone)
	name = npc_get_name_COMMON(clientObject)

npcID = x*10000+y
targetID = npcID

boxes = undefined
lootBoxes = undefined

target = undefined
function_call_COMMON(choose_target, 1, true)

visible = global.drawServer_SERVER