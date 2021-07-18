#region FUNCTION DECLARATIONS
function recreate_shadow_surface() {
	if (!surface_exists(shadowSurface)) {
		var spriteOffset_x_before = sprite_get_xoffset(sprite_index)
		var spriteOffset_y_before = sprite_get_yoffset(sprite_index)
		sprite_set_offset(sprite_index, 0, 0)
		
		var outlineWidth = 0.15
		var outlineColor = c_dkgray
		
		var obstacle_sprite = obstacleSprite
		var obstacle_width = sprite_get_width(obstacle_sprite)*(1+outlineWidth)
		var obstacle_height = sprite_get_height(obstacle_sprite)*(1+outlineWidth)

		var width = sprite_get_width(sprite_index)
		var height = sprite_get_height(sprite_index)
		var spriteDifference_x = obstacle_width-width
		var spriteDifference_y = obstacle_height-height
	
		shadowSurface = surface_create(obstacle_width*image_xscale, obstacle_height*image_yscale)

		surface_set_target(shadowSurface)
			for (var i = 0; i < abs(image_xscale); i++)
				for (var j = 0; j < abs(image_yscale); j++) {
					var xx = obstacle_width/2+i*width*sign(image_xscale)
					var yy = obstacle_height/2+j*height*sign(image_yscale)
				
					draw_sprite_ext(obstacle_sprite, irandom(sprite_get_number(obstacle_sprite)-1), xx, yy, 1+outlineWidth, 1+outlineWidth, 0, outlineColor, 1)
			
				}
		surface_reset_target()
	
		shadowSurface_x = x-lengthdir_x(spriteDifference_x/2, image_angle)+lengthdir_y(spriteDifference_y/2, image_angle)
		shadowSurface_y = y-lengthdir_x(spriteDifference_x/2, image_angle)-lengthdir_y(spriteDifference_y/2, image_angle)
	
		sprite_set_offset(sprite_index, spriteOffset_x_before, spriteOffset_y_before)
	}
}
function recreate_obstacle_surface() {
	if (!surface_exists(obstacleSurface)) {
		var spriteOffset_x_before = sprite_get_xoffset(sprite_index)
		var spriteOffset_y_before = sprite_get_yoffset(sprite_index)
		sprite_set_offset(sprite_index, 0, 0)
		
		var obstacle_sprite = obstacleSprite
		var obstacle_width = sprite_get_width(obstacle_sprite)
		var obstacle_height = sprite_get_height(obstacle_sprite)

		var width = sprite_get_width(sprite_index)
		var height = sprite_get_height(sprite_index)
		
		var spriteDifference_x = obstacle_width-width
		var spriteDifference_y = obstacle_height-height
	
		obstacleSurface = surface_create(obstacle_width*image_xscale, obstacle_height*image_yscale)

		surface_set_target(obstacleSurface)
			for (var i = 0; i < abs(image_xscale); i++)
				for (var j = 0; j < abs(image_yscale); j++) {
					var xx = obstacle_width/2+i*width*sign(image_xscale)
					var yy = obstacle_height/2+j*height*sign(image_yscale)
				
					draw_sprite_ext(obstacle_sprite, irandom(sprite_get_number(obstacle_sprite)-1), xx, yy, 1, 1, 0, c_white, 1)
				}
		surface_reset_target()
	
		obstacleSurface_x = x-lengthdir_x(spriteDifference_x/2, image_angle)+lengthdir_y(spriteDifference_y/2, image_angle)
		obstacleSurface_y = y-lengthdir_x(spriteDifference_x/2, image_angle)-lengthdir_y(spriteDifference_y/2, image_angle)
	
		sprite_set_offset(sprite_index, spriteOffset_x_before, spriteOffset_y_before)
	}
}
#endregion

event_inherited()

shadowSurface = noone
shadowSurface_x = 0
shadowSurface_y = 0

obstacleSurface = noone
obstacleSurface_x = 0
obstacleSurface_y = 0

polygon = undefined
flags |= eShadowCasterFlags.Static