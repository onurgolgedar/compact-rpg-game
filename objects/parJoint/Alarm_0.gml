var decrease = 0.07
if (image_alpha-decrease > 0)
	image_alpha -= decrease
else {
	instance_destroy()
	image_alpha = 0
}
	
alarm[0] = SEC/30