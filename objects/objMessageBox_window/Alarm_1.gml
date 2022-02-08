var decrease = delta()

if (duration-decrease > 0)
	duration -= decrease
else if (duration != -1)
	instance_destroy()
	
alarm[1] = 1