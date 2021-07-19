if (collector != undefined and instance_exists(collector)) {
	var ds_size = ds_list_size(coins)
	for (var i = 0; i < ds_size; i++) {
		var coin = ds_list_find_value(coins, i)
		with (coin) {
			var pow = 320
			var dir = point_direction(x, y, other.collector.x, other.collector.y)
			ds_map_add(spds, other.collector, {xx: lengthdir_x(pow, dir), yy: lengthdir_y(pow, dir)})
		}
	}
}