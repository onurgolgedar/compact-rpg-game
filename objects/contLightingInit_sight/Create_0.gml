surf_shadow = -1
surf_light = -1
update = 1

global.u_maxlength = shader_get_uniform(sh_shadow_renderer, "maxlength")
global.u_alpha = shader_get_uniform(sh_shadow_renderer, "alpha")
global.u_mat = shader_get_uniform(sh_shadow_renderer, "mat")

global.u_mask = shader_get_sampler_index(sh_source_renderer, "mask")
global.u_lightmask = shader_get_uniform(sh_source_renderer, "lightmask")
global.u_tcolor = shader_get_uniform(sh_source_renderer, "tcolor")
