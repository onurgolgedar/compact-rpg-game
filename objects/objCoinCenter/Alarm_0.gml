var coinCount = irandom_range(3, 6)
repeat (coinCount) {
	var coin = instance_create_layer(x, y, "Floor", objCoin)
	with (coin) {
		value = other.value/coinCount
		center = other.id
		var pow = irandom_range(200, 350)*(1+(irandom(2) == 0)*random_range(0.15, 1.05))
		var dir = irandom(359)
		ds_map_add(spds, irandom(999999), {xx: lengthdir_x(pow, dir), yy: lengthdir_y(pow, dir)})
	}
	ds_list_add(coins, coin)
}