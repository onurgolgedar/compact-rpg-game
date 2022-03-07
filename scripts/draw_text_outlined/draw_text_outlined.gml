function draw_text_outlined(xx, yy, str, outwidth, outcol, outfidelity, xscale, yscale, angle) {
	var dto_dcol = draw_get_color()
	var dto_dalpha = draw_get_alpha()
	
	draw_set_color(outcol)
	draw_set_alpha(dto_dalpha > 0.1 ? dto_dalpha*dto_dalpha : 0)
		for (var dto_i = 45; dto_i < 405; dto_i += 360/outfidelity)
		    draw_text_transformed(xx+lengthdir_x(outwidth, dto_i), yy+lengthdir_y(outwidth, dto_i), str, xscale, yscale, angle)
	draw_set_alpha(dto_dalpha)
	draw_set_color(dto_dcol)
	
	draw_text_transformed(xx, yy, str, xscale, yscale, angle)
}
