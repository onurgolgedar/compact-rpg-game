barVisible = instance_exists(objPlayer) and point_distance(x, y, objPlayer.x, objPlayer.y) < camera_get_view_width(global.camera)/2 and !collision_line(x, y, objPlayer.x, objPlayer.y, objObstacleCreator, true, true) and !place_meeting(x, y, parTree)

alarm[2] = room_speed/5