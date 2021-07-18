// Update the shadow map

if (global.lighting) {
	var exists

	if (dirty or tick >= global.lightUpdateFrameDelay or global.worldShadowMap == undefined or !surface_exists(global.worldShadowMap)) {
		// Composite shadow map
		exists = composite_shadow_map(global.worldLights)
		dirty = false
		tick = 0
	}
	else
		exists = surface_exists(global.worldShadowMap)

	if (exists) {
		// Get the active camera
		var camera = lighting_get_active_camera()
		// Draw the shadow map
		draw_shadow_map(camera[eLightingCamera.X], camera[eLightingCamera.Y])
	}
}