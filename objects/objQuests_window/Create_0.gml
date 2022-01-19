event_inherited()

title = "QUESTS"

offset = 4
height_ext_top = 57

width = 350
height = 400

pageCount = 3
page = 1

activeQuests_shortDescriptions = ds_map_create()
net_client_send(_CODE_GET_ACTIVE_QUESTS)
alarm[10] = SEC/4