function text_shorten_oneline(text, width, font) {
	var beforeFont = draw_get_font()
	if (font != undefined)
		draw_set_font(font)

	var shortDesc = undefined
	for (var i = 1; i <= string_length(text); i++) {
		var lineSkip = string_count("\n", string_copy(text, 0, i))
	    if (string_width(string_copy(text, 0, i)) > width or lineSkip) {
	        shortDesc = string_copy(text, 0, i-3+lineSkip*2)+strret("...", !lineSkip)
	        break
	    }
	    else
			shortDesc = string_copy(text, 0, i)
	}
	
	draw_set_font(beforeFont)
	
	return shortDesc
}

function strret(text, isReturned) {
	if (isReturned)
	    return text

	return ""
}