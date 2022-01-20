event_inherited()

title = "QUESTS"

offset = 4
height_ext_top = 57

width = 365
height = 400

pageCount = 7
page = 1

net_client_send(_CODE_GET_ACTIVE_QUESTS)
alarm[10] = SEC/4
prepDone = false