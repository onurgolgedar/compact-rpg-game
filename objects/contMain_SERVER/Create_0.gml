global.lastPositions_sent = ds_map_create()

// Non-table Data
global.playerBoxes = ds_map_create() // Items
global.playerQuests = ds_map_create() // Quests
global.playerSkills = ds_map_create() // Skill Tree
global.playerSkillBoxes = ds_map_create() // Skill Boxes
global.playerPermanentEffectBoxes = ds_map_create() // Permanent Effect Boxes

global.locations = ds_map_create() // Locations
ds_map_add(global.locations, 1, new location("Castle of Tophra", 1, 850, 600))
ds_map_add(global.locations, 2, new location("Front of the Castle", 1, 4310, 2600))
ds_map_add(global.locations, 3, new location("Arena", 1, 13429, 2444))

// Inventory Data
global.bc_hor_COMMON = 5
global.bc_ver_COMMON = 5
global.pageCount_COMMON = 3
global.boxEmpty_COMMON = box_create_COMMON()

// Skill Tree Data
global.sc_hor_COMMON = 4
global.sc_ver_COMMON = 4
global.pageCount_skill_COMMON = 3
global.boxEmpty_skill_COMMON = { skill: undefined }

// Server Control Mode
global.drawEventEnabled = true
global.selectedPlayer = undefined
global.playerControlMode = false

define_skills_base_COMMON()

alarm[0] = room_speed/30
alarm[1] = room_speed/10

wheel_x = undefined
wheel_y = undefined