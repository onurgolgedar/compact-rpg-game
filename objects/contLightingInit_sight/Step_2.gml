#region setup
var cam = view_camera[0];
var x0 = camera_get_view_x(cam), y0 = camera_get_view_y(cam),
	cw = camera_get_view_width(cam), ch = camera_get_view_height(cam);
	
var w = ceil(cw * quality), h = ceil(ch * quality);

if surface_exists(surf_light) {
	if surface_get_width(surf_light) != w
	or surface_get_height(surf_light) != h
	{
		surface_free(surf_light)
		if surface_exists(surf_shadow)
			surface_free(surf_shadow)
	}
}

if !surface_exists(surf_light) {
	update = 1
	surf_light = surface_create(w, h)
	surf_shadow = surface_create(w, h)
}
update = 1

#endregion

var mt = matrix_get(matrix_world);
matrix_set(matrix_world, matrix_build(-x0*quality, -y0*quality, 0, 0, 0, camera_get_view_angle(cam), quality, quality, 1))


#region render shadows and lights
if update {
	
	draw_set_color(c_white)
	surface_set_target(other.surf_light)
	draw_clear_alpha(ambient mod power(256, 3), 1 - ambient div power(256, 3) / 255)
	surface_reset_target()
	
	var q =  [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]],
		qs = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]],
		i = 0, ii = 0, n = instance_number(parLight_sight), tid = [];
	with parLight_sight {
		ii++
		
		if ii!=n and !isDirectional 
		if xmin > x0 + cw
		or xmax < x0
		or ymin > y0 + ch
		or ymax < y0
			continue
		
		q[i] = [x, y, 1, z]
		if isDirectional {
			qs[i] = [-lengthdir_x(1, image_angle+90), -lengthdir_y(1, image_angle+90), 1.4*z*max(0.000001, abs(tan(degtorad(zDirection)))), 1]
		} 
		else
			qs[i] = [0, 0, 0, 0]
		tid[i] = real(id)
		i++
		
		if i == 4 or ii == n {
			
			surface_set_target(other.surf_shadow)
			draw_clear(c_white)
			gpu_set_blendmode_ext ( bm_zero, bm_inv_src_color )
			shader_set(sh_shadow_renderer)
			
			shader_set_uniform_f(global.u_maxlength, other.MaxShadowLength)
			shader_set_uniform_f_array(global.FG_su_lp0, q[0]);		shader_set_uniform_f_array(global.FG_su_lps0, qs[0])
			shader_set_uniform_f_array(global.FG_su_lp1, q[1]);		shader_set_uniform_f_array(global.FG_su_lps1, qs[1])
			shader_set_uniform_f_array(global.FG_su_lp2, q[2]);		shader_set_uniform_f_array(global.FG_su_lps2, qs[2])
			shader_set_uniform_f_array(global.FG_su_lp3, q[3]);		shader_set_uniform_f_array(global.FG_su_lps3, qs[3])
			
			with objShadowLine_sight {
				shader_set_uniform_matrix_array(global.u_mat, matrix_build(x, y, z, 0, 0, image_angle, 1, 1, 1))
				shader_set_uniform_f(global.u_alpha, image_alpha)
				vertex_submit(mymask, pr_trianglelist, -1)
			}
			shader_reset()
			surface_reset_target()
			
			surface_set_target(other.surf_light)
			gpu_set_blendmode_ext( bm_one, bm_one)
			shader_set(sh_source_renderer)
			texture_set_stage(global.u_mask, surface_get_texture(other.surf_shadow))
			for(var j=0; j<i; j++) {
				with tid[j] {
					shader_set_uniform_f(global.u_tcolor, c[0], c[1], c[2])
					shader_set_uniform_f(global.u_lightmask, j==0, j==1, j==2, j==3)
					if isDirectional {
						draw_set_alpha(strong)
						draw_rectangle(x0, y0, x0+cw, y0+ch, 0)
						draw_set_alpha(1)
					}
					else
						draw_sprite_ext(mask, -1, x, y, xscale, yscale, image_angle, c_white, strong)
				}
			}
			shader_reset()
			surface_reset_target()
			gpu_set_blendmode(bm_normal)
			
			i = 0
		}
	}
	draw_set_color(c_black)
	update = 0
}
#endregion

matrix_set(matrix_world, mt)