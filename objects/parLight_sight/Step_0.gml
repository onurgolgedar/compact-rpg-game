if behavior != noone {
	script_execute(behavior)
}

color = Color mod (256*256*256)
c[0] = (color mod 256) / 255; color = color div 256
c[1] = (color mod 256) / 255; color = color div 256
c[2] =  color          / 255

if width != -1
or height != -1
or radius != -1 
or mask != index
or angle != image_angle
or x!=xprevious
or y!=yprevious
	update = 1

if update {
	var w = sprite_get_width(mask),
		h = sprite_get_height(mask);
		
	if width==-1 or height==-1 {
		if radius == -1 {
			xscale = 1
			yscale = 1
		} else {
			xscale = radius/max(w, h)
			yscale = xscale
		}
	} else {
		xscale = width / w
		yscale = height / h
	}
	
	w *= xscale
	h *= yscale
	
	var w0 = sprite_get_xoffset(mask) * xscale,
		w1 = w - w0,
		h0 = sprite_get_yoffset(mask) * yscale,
		h1 = h - h0,
		lx = lengthdir_x(1, image_angle), ly = lengthdir_y(1, image_angle);
		
	x0 = x + w0*lx + h0*ly
	y0 = y + w0*ly + h0*lx
	
	x1 = x - w0*lx + h0*ly
	y1 = y - w0*ly + h0*lx
	
	x2 = x + w0*lx - h0*ly
	y2 = y + w0*ly - h0*lx
	
	x3 = x - w0*lx - h0*ly
	y3 = y - w0*ly - h0*lx
	
	xmin = min(x0, x1, x2, x3)
	xmax = max(x0, x1, x2, x3)
	ymin = min(y0, y1, y2, y3)
	ymax = max(y0, y1, y2, y3)
	
	width = -1
	height = -1
	radius = -1
	index = mask
	update = 0
}
