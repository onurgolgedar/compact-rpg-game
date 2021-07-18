#region FUNCTION DECLARATIONS
function set_style(hair, clothes){
	id.hair = hair
	shoulders.sprite_index = clothes
}
#endregion

event_inherited()

name = undefined
hp = undefined
energy = undefined
mana = undefined
maxHp = undefined
maxEnergy = undefined
maxMana = undefined
stunned = false

texts = ds_list_create()

weaponSprite = sprNothingness

sx = undefined
sy = undefined