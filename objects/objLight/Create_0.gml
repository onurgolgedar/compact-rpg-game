#region FUNCTION DECLARATIONS
function recreate_light() {
	if (light != undefined)
		event_perform(ev_cleanup, 0)

	switch (Light_Type) {
		case "Point Light":
			light = light_create_point(x, y, Light_Shadow_Length, Light_Color, Light_Range, Light_Intensity)
			break
		
		case "Spot Light":
			light = light_create_spot(x, y, Light_Shadow_Length, Light_Color, Light_Range, Light_Intensity, Light_Angle, Light_Direction)
			break
		
		case "Area Light":
			light = light_create_area(x, y, Light_Shadow_Length, Light_Color, Light_Range, Light_Intensity, Light_Width, Light_Direction)
			image_angle = Light_Direction
			break
		
		case "Directional Light":
			light = light_create_directional(x, y, Light_Shadow_Length, Light_Color, Light_Range, Light_Intensity, Light_Direction)
			image_angle = Light_Direction
			break
		
		case "Line Light":
			light = light_create_line(x, y, Light_Shadow_Length, Light_Color, Light_Range, Light_Intensity, Light_Width, Light_Direction)
			image_angle = Light_Direction
			break
	}
	
	// Set LUTs
	if (LUT_Intensity != noone)
		light[| eLight.LutIntensity] = sprite_get_texture(LUT_Intensity, 0)
	
	light_add_to_world(light)
}
#endregion

light = undefined

recreate_light()