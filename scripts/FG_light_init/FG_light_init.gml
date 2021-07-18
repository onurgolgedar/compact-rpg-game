function FG_light_init() {
	vertex_format_begin()
	vertex_format_add_position_3d()
	vertex_format_add_color()
	global.FG_light_vertex_format = vertex_format_end()

#macro FG_light_vf global.FG_light_vertex_format

	enum FG_ligt_SM {
		linestrip,
		linelist,
		linestrip_close
	}

	global.FG_su_lp0 = shader_get_uniform(sh_shadow_renderer, "lp0")
	global.FG_su_lp1 = shader_get_uniform(sh_shadow_renderer, "lp1")
	global.FG_su_lp2 = shader_get_uniform(sh_shadow_renderer, "lp2")
	global.FG_su_lp3 = shader_get_uniform(sh_shadow_renderer, "lp3")

	global.FG_su_lps0 = shader_get_uniform(sh_shadow_renderer, "lps0")
	global.FG_su_lps1 = shader_get_uniform(sh_shadow_renderer, "lps1")
	global.FG_su_lps2 = shader_get_uniform(sh_shadow_renderer, "lps2")
	global.FG_su_lps3 = shader_get_uniform(sh_shadow_renderer, "lps3")

	global.FG_su_mat = shader_get_uniform(sh_shadow_renderer, "mat")


}
