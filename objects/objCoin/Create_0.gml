image_angle = irandom(359)
image_index = irandom(image_number-1)
image_speed = 0

sparkle_currentFrame = irandom(32)
sparkle_rotation = irandom(359)

image_xscale *= random_range(1.2, 1.5)
image_yscale *= image_xscale

image_angle_speed = choose(3, -3)

elasticity = 0.5
spds = ds_map_create()
spd = { xx: 0, yy: 0 }
spd_res = { xx: 0, yy: 0 }

collector = undefined
center = undefined
moving = false