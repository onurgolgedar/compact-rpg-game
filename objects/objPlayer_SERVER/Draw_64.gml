var xx = screen_point(x, 0)
var yy = screen_point(y, 1)
	
/*draw_set_halign(fa_center) draw_set_color(c_white)
	draw_text(xx, yy-48, name)
draw_set_halign(fa_left) draw_set_color(c_black)*/

draw_set_color(c_white)
	draw_rectangle(xx-30, yy-80, xx+30, yy-71, 0)
draw_set_color(c_black)
	draw_rectangle(xx-28, yy-78, xx-28+56*hp/maxHp, yy-73, 0)
draw_set_color(c_black)

draw_set_color(c_white)
	draw_rectangle(xx-30, yy-70, xx+30, yy-61, 0)
draw_set_color(c_black)
	draw_rectangle(xx-28, yy-68, xx-28+56*mana/maxMana, yy-63, 0)
draw_set_color(c_black)
	
draw_set_color(c_white)
	draw_rectangle(xx-30, yy-60, xx+30, yy-51, 0)
draw_set_color(c_black)
	draw_rectangle(xx-28, yy-58, xx-28+56*energy/maxEnergy, yy-53, 0)
draw_set_color(c_black)
	
var _spds_keys = ds_map_keys_to_array(spds)
var ds_size = array_length(_spds_keys)
draw_set_color(c_white)
for (var i = 0; i < ds_size; i++)
	draw_arrow(xx, yy, xx+spds[? _spds_keys[i]].xx/8, yy+spds[? _spds_keys[i]].yy/8, 10)
draw_set_color(c_black)
delete _spds_keys