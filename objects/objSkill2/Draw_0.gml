if (lock) {
	if (instance_exists(owner)) {
		draw_sprite_ext(sprite_index, image_index, owner.x, owner.y, image_xscale, image_yscale, image_angle, image_blend, image_alpha*0.7)
		draw_sprite_ext(sprite_index, image_index, owner.x, owner.y, image_xscale+0.05, image_yscale+0.05, image_angle, image_blend, image_alpha*0.3)
	
		draw_set_alpha(0.4) draw_set_color(c_red)
			draw_circle(owner.x, owner.y, 6, 0)
			draw_circle(owner.x, owner.y, 11, 0)
		draw_set_alpha(1) draw_set_color(c_black)
	}
}
else
	draw_self()