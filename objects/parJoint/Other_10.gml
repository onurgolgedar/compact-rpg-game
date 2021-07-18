with (parJoint)
	if (owner == other.id) {
		image_angle = other.image_angle+target*side
		x = other.x+lengthdir_x(lock_dis, lock_dir+other.image_angle)
		y = other.y+lengthdir_y(lock_dis, lock_dir+other.image_angle)
		
		event_user(0)
	}