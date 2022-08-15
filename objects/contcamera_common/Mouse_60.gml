if (!is_in_game_room_COMMON())
	exit

var zoomLimit = floor(768*0.6)
var factor = 1/1.2

if (targetZoom == undefined)
	targetZoom = camera_get_view_height(global.camera)*factor

if (targetZoom > zoomLimit)
	targetZoom *= factor
else if (targetZoom != zoomLimit)
	targetZoom = zoomLimit

alarm[0] = 1