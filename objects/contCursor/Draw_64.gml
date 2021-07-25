if (global.held_box != undefined) {
	draw_outline_origin(global.held_box.item.sprite, -1, global.dmx, global.dmy, 0.47, 0.47, 60, 1)
	draw_sprite_origin_ext(global.held_box.item.sprite, -1, global.dmx, global.dmy, 0.47, 0.47, 60, c_white, 1)
}