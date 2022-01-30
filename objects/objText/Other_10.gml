if (surface != undefined)
	surface_free(surface)

text_width = 0
text_height = 0

var subtexts = ds_list_create()
var PADDING = {left: 0, top: 0}
var OFFSET = 0
draw_set_font(font_bold)
draw_set_color(font_color)

var _subtext = ""
var _subcolor = c_white
var _xx = 0
var _yy = 0
var _bold = false

for (var i = 1, j = 1; i < string_length(text); i++) {
	if (i+1 == string_length(text)) {
		_subtext += string_copy(text, j, string_length(text)-j+1)
		ds_list_add(subtexts, { data: _subtext, xx: _xx, yy: _yy, image: undefined, color: _subcolor, bold: _bold })
		_subtext = ""
		_xx = 0
	}
	
	if (string_char_at(text, i) == "\n") {
		_subtext += string_copy(text, j, i-j)
		ds_list_add(subtexts, { data: _subtext, xx: _xx, yy: _yy, image: undefined, color: _subcolor, bold: _bold })
		_subtext = ""
		_xx = 0
		
		_yy += string_height("|")+line_spacing
		j = i+1
		continue
	}
	
	if (string_copy(text, i, 4) == "[/c]") {
		_subtext += string_copy(text, j, i-j)
		ds_list_add(subtexts, { data: _subtext, xx: _xx, yy: _yy, image: undefined, color: _subcolor, bold: _bold })
		draw_set_font(_bold ? font_bold : font)
		_xx += string_width(_subtext)
		_subtext = ""

		j = i+4
		continue
	}
	
	if (string_copy(text, i, 4) == "[/b]") {
		_subtext += string_copy(text, j, i-j)
		ds_list_add(subtexts, { data: _subtext, xx: _xx, yy: _yy, image: undefined, color: _subcolor, bold: _bold })
		draw_set_font(_bold ? font_bold : font)
		_xx += string_width(_subtext)
		_subtext = ""
		_bold = false

		j = i+4
		continue
	}
	
	if (string_copy(text, i, 3) == "[b]") {
		_subtext += string_copy(text, j, i-j)
		ds_list_add(subtexts, { data: _subtext, xx: _xx, yy: _yy, image: undefined, color: _subcolor, bold: _bold })
		draw_set_font(_bold ? font_bold : font)
		_xx += string_width(_subtext)
		_subtext = ""
		
		_bold = true
		j = i+3
		continue
	}
	
		
	if (string_copy(text, i, 3) == "[c=") {
		_subtext += string_copy(text, j, i-j)
		ds_list_add(subtexts, { data: _subtext, xx: _xx, yy: _yy, image: undefined, color: _subcolor, bold: _bold })
		draw_set_font(_bold ? font_bold : font)
		_xx += string_width(_subtext)
		_subtext = ""
			
		var _subcolor = ""
		var k = 1
		while (string_char_at(text, i+2+k) != "]") {
			_subcolor += string_char_at(text, i+2+k)
			k++
		}

		_subcolor = real(_subcolor)

		j = i+3+k
		continue
	}
	
	if (string_copy(text, i, 3) == "[c=") {
		_subtext += string_copy(text, j, i-j)
		ds_list_add(subtexts, { data: _subtext, xx: _xx, yy: _yy, image: undefined, color: _subcolor, bold: _bold })
		draw_set_font(_bold ? font_bold : font)
		_xx += string_width(_subtext)
		_subtext = ""
			
		var _subcolor = ""
		var k = 1
		while (string_char_at(text, i+2+k) != "]") {
			_subcolor += string_char_at(text, i+2+k)
			k++
		}

		_subcolor = real(_subcolor)

		j = i+3+k
		continue
	}
	
		
	if (string_copy(text, i, 5) == "[img=") {
		_subtext += string_copy(text, j, i-j)
		ds_list_add(subtexts, { data: _subtext, xx: _xx, yy: _yy, image: undefined, color: _subcolor, bold: _bold })
		draw_set_font(_bold ? font_bold : font)
		_xx += string_width(_subtext)
		_subtext = ""
			
		var _image = ""
		var k = 1
		while (string_char_at(text, i+4+k) != "]") {
			_image += string_char_at(text, i+4+k)
			k++
		}
				
		_image = asset_get_index(_image)
		_xx += sprite_get_width(_image)/2+OFFSET/2+2
		ds_list_add(subtexts, { data: "", xx: _xx, yy: _yy+string_height("|")/2+line_spacing/2, image: _image, color: c_white, bold: _bold })
		_xx += sprite_get_width(_image)/2+OFFSET/2+6
		j = i+5+k
		continue
	}
}

for (var i = 0; i < ds_list_size(subtexts); i++) {
	var _subtext = ds_list_find_value(subtexts, i)
	text_width = max(text_width, string_width(_subtext.data)+_subtext.xx)
	text_height = max(text_height, string_height(_subtext.data)+_subtext.yy)
}
text_width += PADDING.left
text_height += PADDING.top

gpu_set_colorwriteenable(1, 1, 1, 1)
surface = surface_create(text_width+6, text_height+6)
surface_set_target(surface)
	draw_clear_alpha(c_black, 0)
surface_reset_target()

for (var i = 0; i < ds_list_size(subtexts); i++) {
	var subsurface = surface_create(text_width+6, text_height+6)
	var _subtext = ds_list_find_value(subtexts, i)
	
	surface_set_target(subsurface) draw_clear_alpha(c_black, 0) gpu_set_tex_filter(false)
		if (_subtext.image == undefined) {
			var beforeColor = draw_get_color()
			draw_set_font(_subtext.bold ? font_bold : font) draw_set_color(_subtext.color)
				draw_text_outlined(_subtext.xx+PADDING.left+3, _subtext.yy+PADDING.top+3, _subtext.data, outlineWidth, c_black, outlineFidelity, 1, 1, 0)
			draw_set_color(beforeColor)
		}
		else
			draw_sprite(_subtext.image, -1, _subtext.xx+PADDING.left+3, _subtext.yy+PADDING.top+3)
	surface_reset_target()
	
	 surface_set_target(surface) 
		draw_surface(subsurface, 0, 0)
	surface_reset_target() 
	
	surface_free(subsurface)
}
gpu_set_colorwriteenable(1, 1, 1, 1)

draw_set_font(font_before)
draw_set_color(color_before)
ds_list_destroy(subtexts)

width = text_width+padding_x*2+2
height = -padding_y*2-text_height