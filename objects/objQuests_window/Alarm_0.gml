var ds_size = ds_map_size(global.activeQuests_player)
var ds_keys = ds_map_keys_to_array(global.activeQuests_player)
for (var i = (page-1)*6; i < ds_size and i < page*6; i++) {
	var activeQuest = global.activeQuests_player[? ds_keys[i]]
	activeQuest.shortDescription = text_shorten_oneline(activeQuest.description, width-33, fontGUi_small)
}

alarm[0] = SEC/4
prepDone = true