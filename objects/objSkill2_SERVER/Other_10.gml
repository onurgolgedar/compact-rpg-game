if (instance_exists(owner)) {			
	var laser_length = 1500
	var col_x =  undefined
	var col_y = undefined
	for (var len = 25; len < laser_length; len += 25) {
		var xx = x+lengthdir_x(len, image_angle)
		var yy = y+lengthdir_y(len, image_angle)
		
		var offset_x = 0
		var offset_y = 0
		if (laser_index != 0) {
			offset_x = lengthdir_x(25, image_angle)
			offset_y = lengthdir_y(25, image_angle)
		}
		
		var collisionObject = collision_line(x+offset_x, y+offset_y, xx, yy, objCollision_SERVER, false, false)
		if (collisionObject != noone) {
			col_x = xx
			col_y = yy
			break
		}
	}
				
	if (collisionObject != noone) {
		var dis = point_distance(x, y, col_x, col_y)
		image_xscale = dis/sprite_get_width(sprite_index)
	}
	else
		image_xscale = laser_length/sprite_get_width(sprite_index)
	
	net_server_send(SOCKET_ID_ALL, CODE_SKILL2, json_stringify({ socketID: owner.socketID, xx: x, yy: y, angle: image_angle, xscale: image_xscale, lock: laser_index == 0 }), BUFFER_TYPE_STRING, true)

	if (laser_index < 2 and collisionObject != noone) {
		var laser = instance_create_depth(x+lengthdir_x(sprite_width, image_angle), y+lengthdir_y(sprite_width, image_angle), 0, object_index)
		with (laser) {
			owner = other.owner
			skill = other.skill
			laser_index = other.laser_index+1
			
			var center_dir = point_direction(0, 0, collisionObject.dir.xx, collisionObject.dir.yy)
			image_angle = center_dir+angle_difference(center_dir+180, other.image_angle)
				
			event_user(0)
		}
	}
}