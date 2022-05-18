#region FUNCTION DECLARATIONS
function set_style(hair, clothes){
	id.hair = hair
	shoulders.sprite_index = clothes
}
#endregion

event_inherited()

name = undefined
level = undefined
hp = undefined
energy = undefined
mana = undefined
maxHp = undefined
maxEnergy = undefined
maxMana = undefined
movementSpeed = undefined
physicalPower = undefined
magicalPower = undefined
attackSpeed = undefined
stunned = false

texts = ds_list_create()
effectBoxes = ds_list_create()

weaponSprite = sprNothingness

image_angle_target = image_angle
sx = undefined
sy = undefined

healthBarP = 1
energyBarP = 1
manaBarP = 1