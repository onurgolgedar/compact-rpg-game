event_inherited()

title = "QUESTS"

offset = 3
height_ext_top = 50

width = 365
height = 400

pageCount = 7
page = 1

net_client_send(_CODE_GET_ACTIVE_QUESTS)
alarm[0] = SEC/8
prepDone = false