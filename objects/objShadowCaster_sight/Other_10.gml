mymask = FG_light_SM_start()

FG_light_SM_point_z(mymask, 0, 0, z_bottom, z_top)
FG_light_SM_point_z(mymask, sprite_width, 0, z_bottom, z_top)
FG_light_SM_point_z(mymask, sprite_width, sprite_height, z_bottom, z_top)
FG_light_SM_point_z(mymask, 0, sprite_height, z_bottom, z_top)
FG_light_SM_point_z(mymask, 0, 0, z_bottom, z_top)

mymask = FG_light_SM_end(mymask, FG_ligt_SM.linestrip)