event_inherited()

joint_turn_with_velocity(image_angle_target, 2500)

var value = global.delta_COMMON*0.8
if (healthBarP-value > hp/maxHp)
    healthBarP -= value
else
    healthBarP = hp/maxHp
    
if (manaBarP-value > mana/maxMana)
    manaBarP -= value
else
    manaBarP = mana/maxMana
    
if (energyBarP-value*2.5 > energy/maxEnergy)
    energyBarP -= value*2.5
else
    energyBarP = energy/maxEnergy