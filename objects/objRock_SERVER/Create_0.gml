image_alpha = 0.2

var edgeDiff = 0
var thickness = 5

var collision = instance_create_depth(x, y, -500, objCollision_SERVER)
collision.image_xscale = image_xscale
collision.image_yscale = thickness/sprite_get_height(sprite_index)
collision.image_angle = image_angle
collision.dir = { xx: lengthdir_x(1, image_angle+90), yy: lengthdir_y(1, image_angle+90) }

collision = instance_create_depth(x+lengthdir_x(sprite_height, image_angle-90), y+lengthdir_y(sprite_height, image_angle-90), -500, objCollision_SERVER)
collision.image_xscale = image_xscale
collision.image_yscale = -thickness/sprite_get_height(sprite_index)
collision.image_angle = image_angle
collision.dir = { xx: lengthdir_x(1, image_angle-90), yy: lengthdir_y(1, image_angle-90) }

collision = instance_create_depth(x+lengthdir_x(edgeDiff/2, image_angle-90), y+lengthdir_y(edgeDiff/2, image_angle-90), -500, objCollision_SERVER)
collision.image_xscale = thickness/sprite_get_width(sprite_index)
collision.image_yscale = image_yscale*(sprite_height-edgeDiff)/sprite_height
collision.image_angle = image_angle
collision.dir = { xx: lengthdir_x(1, image_angle+180), yy: lengthdir_y(1, image_angle+180) }

collision = instance_create_depth(x+lengthdir_x(sprite_width, image_angle)+lengthdir_x(edgeDiff/2, image_angle-90), y+lengthdir_y(sprite_width, image_angle)+lengthdir_y(edgeDiff/2, image_angle-90), -500, objCollision_SERVER)
collision.image_xscale = -thickness/sprite_get_width(sprite_index)
collision.image_yscale = image_yscale*(sprite_height-edgeDiff)/sprite_height
collision.image_angle = image_angle
collision.dir = { xx: lengthdir_x(1, image_angle), yy: lengthdir_y(1, image_angle) }

visible = global.drawServer