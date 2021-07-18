function destroy() {
	disappearing = 1
	instance_destroy()
}

owner = undefined

image_alpha = 0
disappearing = 0

spd = undefined

function_call(destroy, 1.5, true)