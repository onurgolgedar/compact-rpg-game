global.drawServer_SERVER = !global.drawServer_SERVER

with (all) {
	if (string_count("_SERVER", object_get_name(object_index)))
		visible = global.drawServer_SERVER
}