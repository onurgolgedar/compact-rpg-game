if (room == roomMenu)
	exit

var zoomLimit = floor(768*1.4*(1+2*global.drawServer))
var factor = 1*1.3

if (targetZoom == undefined)
	targetZoom = camera_get_view_height(global.camera)*factor

if (targetZoom < zoomLimit)
	targetZoom *= factor
else if (targetZoom != zoomLimit)
	targetZoom = zoomLimit

alarm[1] = 1