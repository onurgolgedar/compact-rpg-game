mymask = FG_light_SM_start()

var precision = max(sprite_width, sprite_height) > 300
if (precision) {
	FG_light_SM_point_z(mymask, 0, 0, z_bottom, z_top)
	FG_light_SM_point_z(mymask, sprite_width*1/4, 0, z_bottom, z_top)
	FG_light_SM_point_z(mymask, sprite_width*2/4, 0, z_bottom, z_top)
	FG_light_SM_point_z(mymask, sprite_width*3/4, 0, z_bottom, z_top)
	FG_light_SM_point_z(mymask, sprite_width, 0, z_bottom, z_top)
	FG_light_SM_point_z(mymask, sprite_width, sprite_height*1/4, z_bottom, z_top)
	FG_light_SM_point_z(mymask, sprite_width, sprite_height*2/4, z_bottom, z_top)
	FG_light_SM_point_z(mymask, sprite_width, sprite_height*3/4, z_bottom, z_top)
	FG_light_SM_point_z(mymask, sprite_width, sprite_height, z_bottom, z_top)
	FG_light_SM_point_z(mymask, sprite_width*3/4, sprite_height, z_bottom, z_top)
	FG_light_SM_point_z(mymask, sprite_width*2/4, sprite_height, z_bottom, z_top)
	FG_light_SM_point_z(mymask, sprite_width*1/4, sprite_height, z_bottom, z_top)
	FG_light_SM_point_z(mymask, 0, sprite_height, z_bottom, z_top)
	FG_light_SM_point_z(mymask, 0, sprite_height*3/4, z_bottom, z_top)
	FG_light_SM_point_z(mymask, 0, sprite_height*2/4, z_bottom, z_top)
	FG_light_SM_point_z(mymask, 0, sprite_height*1/4, z_bottom, z_top)
	FG_light_SM_point_z(mymask, 0, 0, z_bottom, z_top)
}
else {
	FG_light_SM_point_z(mymask, 0, 0, z_bottom, z_top)
	FG_light_SM_point_z(mymask, sprite_width, 0, z_bottom, z_top)
	FG_light_SM_point_z(mymask, sprite_width, sprite_height, z_bottom, z_top)
	FG_light_SM_point_z(mymask, 0, sprite_height, z_bottom, z_top)
	FG_light_SM_point_z(mymask, 0, 0, z_bottom, z_top)
}

mymask = FG_light_SM_end(mymask, FG_ligt_SM.linestrip)