with (objObstacleCreator) {
	recreate_shadow_surface()
	draw_surface_ext(shadowSurface, shadowSurface_x, shadowSurface_y, 1, 1, image_angle, c_white, 0.8)		
}

gpu_set_tex_filter(false)
	with (objObstacleCreator) {
		recreate_obstacle_surface()
		draw_surface_ext(obstacleSurface, obstacleSurface_x, obstacleSurface_y, 1, 1, image_angle, c_white, 1)
	}
gpu_set_tex_filter(true)