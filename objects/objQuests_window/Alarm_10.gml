var ds_size = ds_map_size(global.activeQuests_player)
var ds_keys = ds_map_keys_to_array(global.activeQuests_player)
for (var i = (page-1)*6; i < ds_size and i < page*6; i++) {
	var activeQuest = global.activeQuests_player[? ds_keys[i]]
		
	ds_map_add(activeQuests_shortDescriptions, i, text_shorten_oneline(activeQuest.description, width-54, fontGUI_small))
}

alarm[10] = SEC/4