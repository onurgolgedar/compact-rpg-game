event_user(0)

var headOffset_lx = lengthdir_x(headOffset, image_angle+180)
var headOffset_ly = lengthdir_y(headOffset, image_angle+180)
var headOffset_div1 = headOffset/65
var headOffset_div1_rev = 1-headOffset/65
var headOffset_div2_rev = 1-headOffset/80
var headOffset_div3 = headOffset/15
var headOffset_div4 = headOffset/2

var ds_size = ds_list_size(rigidbodyParts)
for (var rb = 0; rb < ds_size; rb++) {
	var rb_part = ds_list_find_value(rigidbodyParts, rb)
	if (rb_part != shoulders and rb_part != leftHand and rb_part != rightHand)
		with (rb_part)
			draw_outline(sprite_index, -1, x, y, image_xscale, image_yscale*(1-headOffset_div1), image_angle, image_alpha)
}

gpu_set_tex_filter(0)
var ds_size = ds_list_size(rigidbodyParts)
for (var rb = 0; rb < ds_size; rb++) {
	var rb_part = ds_list_find_value(rigidbodyParts, rb)
		
	if (rb_part != shoulders and rb_part != leftHand and rb_part != rightHand) {			
		with (rb_part)
			draw_sprite_ext(sprite_index, -1, x, y, image_xscale, image_yscale*(1-headOffset_div1), image_angle, image_blend, image_alpha)
	}
}
gpu_set_tex_filter(1)

with (leftHand) {
	draw_outline(sprite_index, -1, x, y, image_xscale, image_yscale, image_angle, image_alpha)
	draw_sprite_ext(sprite_index, -1, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
}

with (rightHand) {
	draw_outline(other.weaponSprite, -1, x+lengthdir_x(5, image_angle), y+lengthdir_y(5, image_angle), 1, 1, image_angle+60)
	draw_sprite_ext(other.weaponSprite, -1, x+lengthdir_x(5, image_angle), y+lengthdir_y(5, image_angle), 1, 1, image_angle+60, image_blend, image_alpha)
		
	draw_outline(sprite_index, -1, x, y, image_xscale, image_yscale, image_angle, image_alpha)
	draw_sprite_ext(sprite_index, -1, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
}
		
var breathScale = 0.95+global.period/100
with (shoulders) {
	draw_outline(sprite_index, -1, x, y, breathScale*image_xscale, breathScale*image_yscale*headOffset_div2_rev, image_angle+headOffset_div4, image_alpha)
	draw_sprite_ext(sprite_index, -1, x, y, breathScale*image_xscale, breathScale*image_yscale*headOffset_div2_rev, image_angle+headOffset_div4, image_blend, image_alpha)
}

draw_outline(sprite_index, image_index, x+headOffset_lx, y+headOffset_ly, 1+headOffset_div1, 1+headOffset_div1, image_angle+headOffset_div4)
draw_sprite_ext(sprite_index, image_index, x+headOffset_lx, y+headOffset_ly, 1+headOffset_div1, 1+headOffset_div1, image_angle+headOffset_div4, c_white, image_alpha)
		
draw_outline(hair, -1, x+headOffset_lx, y+headOffset_ly, 1+headOffset_div1, 1+headOffset_div1, image_angle+headOffset_div4)
draw_sprite_ext(hair, -1, x+headOffset_lx, y+headOffset_ly, 1+headOffset_div1, 1+headOffset_div1, image_angle+headOffset_div4, c_white, image_alpha)

draw_sprite_ext(sprite_index, -1, x+lengthdir_x(headOffset, image_angle+180+headOffset*3), y+lengthdir_y(headOffset, image_angle+180+headOffset*3), 0.75+headOffset_div3, 0.75+headOffset_div3, image_angle+headOffset*2, c_red, headOffset_div3)
		
var ds_size = ds_list_size(texts)
for (var i = 0; i < ds_size; i++) {
	var text = texts[| i]
	draw_set_color(text.color) draw_set_align_center() draw_set_alpha(power(text.life/text.maxlife, 0.5))
		draw_text_outlined(x+text.xx, y+text.yy, text.text, 2, c_black, 8, text.size, text.size, 0)
	draw_set_color(c_black) draw_set_align_normal() draw_set_alpha(1)
}