function tte_ext_input_draw() {
	if (surface_exists(tte_surface)) {
		if (update) {
		    var l, px, py,ch = 0, mx, my, mh = 0
		    mx = (device_mouse_x_to_gui(0)-x-padding_left)+scrollx
		    my = (device_mouse_y_to_gui(0)-y-padding_top)+scrolly
    
		    surface_set_target(tte_surface)
		        draw_clear_alpha(0,0)
        
		        draw_set_font(font)
		        draw_set_color(fg)
		        draw_set_alpha(fg_alpha)
        
		        mh = string_height("|")
        
		        var tcx = string_width(string_copy(lines[| line], 1, column-1))-scrollx
		        if (tcx < 0) scrollx = max(0, scrollx-abs(tcx))
		        if (tcx >= (width-padding_left-padding_right-2)) scrollx += tcx-(width-padding_left-padding_right-2)
        
		        var i, tcy = 0, clh
		        for(i = 0; i < line; i++)
					tcy += max(mh, string_height(lines[| i]))
		        tcy -= scrolly
		        clh = max(mh, string_height(lines[| line]))
		        if (tcy < 0) scrolly = max(0, scrolly-abs(tcy))
		        if (tcy >= (height-padding_top-padding_bottom-2-clh)) scrolly += tcy-(height-padding_top-padding_bottom-2-clh)
        
        
		        for(var l = 0; l < ds_list_size(lines); l++) {
					var char = lines[| l]
					
		            if (selVisible and focus) {						
		                draw_set_color(sel)
		                draw_set_alpha(sel_alpha)
		                if (l >= selStartLine && l <= selEndLine) {
		                    if (l == selStartLine && l == selEndLine)
								draw_rectangle(
			                        string_width(string_copy(char, 1, selStartCol-1)) -scrollx,
			                        ch-scrolly,
			                        string_width(string_copy(char, 1, selEndCol-1))-scrollx,
			                        ch+max(mh, string_height(char))-1-scrolly,
		                        false)
		                    else if (l == selStartLine)
								draw_rectangle(
			                        string_width(string_copy(char, 1, selStartCol-1))-scrollx,
			                        ch-scrolly,
			                        string_width(char)-scrollx,
			                        ch+max(mh, string_height(char))-1-scrolly,
			                        false)
		                    else if (l == selEndLine)
								draw_rectangle(
			                        -scrollx,
			                        ch-scrolly,
			                        string_width(string_copy(char, 1, selEndCol-1))-scrollx,
			                        ch+max(mh, string_height(char))-1-scrolly,
			                        false)
		                    else
								draw_rectangle(
			                        -scrollx,
			                        ch-scrolly,
			                        string_width(char)-scrollx,
			                        ch+max(mh, string_height(char))-1-scrolly,
			                        false)
		                }
		                draw_set_color(fg)
		                draw_set_alpha(fg_alpha)
		            }
            
		            if (l == line && caretVisible) {
		                px = string_width(string_copy(char, 1, column-1))-scrollx
		                py = ch-scrolly
		                draw_line(px, py, px, py+max(mh, string_height(char))-1)
		            }
		            draw_text(-scrollx, ch-scrolly, char)
		            ch += max(mh, string_height(char))
		        }
		    surface_reset_target()
    
		    update = false
		}

		draw_set_color(bg)
		draw_set_alpha(bg_alpha)
		draw_roundrect(x, y, x+width-1, y+height-1, false)
	
		draw_surface(tte_surface, x+padding_left, y+padding_top)
		draw_set_color(c_black) draw_set_alpha(1)
	}
}