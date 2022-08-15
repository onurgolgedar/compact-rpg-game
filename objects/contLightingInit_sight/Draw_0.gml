var cam = global.camera
var x0 = camera_get_view_x(cam), y0 = camera_get_view_y(cam),
	cw = camera_get_view_width(cam), ch = camera_get_view_height(cam)

gpu_set_colorwriteenable(1, 1, 1, 0)
if (blur) {
	shader_set(sh_light_renderer_blur)
	shader_set_uniform_f(shader_get_uniform(shader_current(), "strong"), blur_strong)
	draw_surface_ext(surf_light, x0, y0, 1/quality, 1/quality, 0, c_black, 1)
	shader_reset()
	gpu_set_blendmode(bm_add)
	shader_set(sh_light_color_renderer_blur)
	shader_set_uniform_f(shader_get_uniform(shader_current(), "strong"), blur_strong)
	draw_surface_ext(surf_light, x0, y0, 1/quality, 1/quality, 0, c_white, 1)
	shader_reset()
	gpu_set_blendmode(bm_normal)
}
else {
	shader_set(sh_light_renderer)
	draw_surface_ext(surf_light, x0, y0, 1/quality, 1/quality, 0, c_black, 1)
	shader_reset()
	gpu_set_blendmode(bm_add)
	shader_set(sh_light_color_renderer)
	draw_surface_ext(surf_light, x0, y0, 1/quality, 1/quality, 0, c_white, 1)
	shader_reset()
	gpu_set_blendmode(bm_normal)
}
gpu_set_colorwriteenable(1, 1, 1, 1)