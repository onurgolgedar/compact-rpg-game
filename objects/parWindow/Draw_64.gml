/*draw_text(x, y, depth)
draw_text(x, y+60, onFront)*/

var xx = x+width-25
var yy = y+3
var buttonLength = 20

draw_set_alpha(image_alpha)

// Button
isOnExitButton = false
if (point_distance(xx+buttonLength/2, yy+buttonLength/2, global.dmx, global.dmy) < buttonLength/2)
	isOnExitButton = true

draw_roundrect(xx-2, yy-2, xx+buttonLength+2, yy+buttonLength+2, 0)
draw_set_color(isOnExitButton ? c_red : c_dkgray)
	draw_roundrect(xx, yy, xx+buttonLength, yy+buttonLength, 0)
draw_set_color(c_black) draw_set_center() draw_set_alpha(1*image_alpha)
	draw_text(x+width-14, y+13, "x")
draw_set_default() draw_set_alpha(1)