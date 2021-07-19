global.selectedPlayer = undefined
global.playerControlMode = false

global.lastPositions_sent = ds_map_create()

global.playerBoxes = ds_map_create()
global.boxEmpty_COMMON = {item: undefined, tag: {isActive: false, isForQuest: false}, count: 0}
global.bc_hor_COMMON = 5
global.bc_ver_COMMON = 5
global.pageCount_COMMON = 3

define_skills_SERVER()

alarm[0] = room_speed/30

wheel_x = undefined
wheel_y = undefined