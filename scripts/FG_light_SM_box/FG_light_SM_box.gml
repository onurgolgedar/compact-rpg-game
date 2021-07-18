/// @arg x0
/// @arg y0
/// @arg x1
/// @arg y1
/// @arg z0
/// @arg z1
function FG_light_SM_box(argument0, argument1, argument2, argument3, argument4, argument5) {

	var mask = FG_light_SM_start();

	FG_light_SM_point_z(mask, argument0, argument1, argument4, argument5)
	FG_light_SM_point_z(mask, argument2, argument1, argument4, argument5)
	FG_light_SM_point_z(mask, argument2, argument3, argument4, argument5)
	FG_light_SM_point_z(mask, argument0, argument3, argument4, argument5)
	FG_light_SM_point_z(mask, argument0, argument1, argument4, argument5)

	return FG_light_SM_end(mask, FG_ligt_SM.linestrip, 0, (argument0 + argument2)/2, (argument1+argument3)/2);



}
