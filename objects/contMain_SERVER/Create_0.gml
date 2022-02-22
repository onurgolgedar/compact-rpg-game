global.lastPositions_sent = ds_map_create()

// Non-table Data
global.playerBoxes = ds_map_create() // Items
global.playerQuests = ds_map_create() // Quests
global.playerSkills = ds_map_create() // Skill Tree
global.playerSkillBoxes = ds_map_create() // Skill Boxes

global.locations = ds_map_create() // Locations
ds_map_add(global.locations, 1, {name: "Area 1", code: 1, spawn_x: 1132, spawn_y: 1673})
ds_map_add(global.locations, 2, {name: "Area 2", code: 2, spawn_x: 6612, spawn_y: 2444})
ds_map_add(global.locations, 3, {name: "Area 3", code: 3, spawn_x: 10930, spawn_y: 1620})

// Inventory Data
global.bc_hor_COMMON = 5
global.bc_ver_COMMON = 5
global.pageCount_COMMON = 3
global.boxEmpty_COMMON = {item: undefined, tag: {isActive: false, isForQuest: false}, count: 0}

// Skill Tree Data
global.sc_hor_COMMON = 4
global.sc_ver_COMMON = 4
global.pageCount_skill_COMMON = 3
global.boxEmpty_skill_COMMON = {skill: undefined}

// Server Control Mode
global.selectedPlayer = undefined
global.playerControlMode = false

define_skills_base_COMMON()

alarm[0] = room_speed/30

wheel_x = undefined
wheel_y = undefined