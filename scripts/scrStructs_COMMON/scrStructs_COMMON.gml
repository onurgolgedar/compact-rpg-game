// ! THEY NEED TO BE THE SAME VERSION (SERVER & CLIENT)
// ?

function st_dialogueButton(_text, _image = undefined, _value = undefined) constructor
{
    text = _text
    image = _image
	hover = false
	value = _value
}

function st_location(_name, _code, _spawn_x, _spawn_y) constructor
{
    name = _name
    code = _code
	spawn_x = _spawn_x
	spawn_y = _spawn_y
}

function st_effectBox(_code, _name, _owner, _creator, _level = -1, _maxTime = -1, _directDestroy = true, _isDeletable = true, _isPermanent = false, _separate = false, _isStackable = false, _stackCount = 1, _maxStackCount = 1, _description = "", _sprite = "sprNothingness") constructor
{
	code = _code
	name = _name
    owner = _owner
    creator = _creator
	level = _level
	time = _maxTime
	maxTime = _maxTime
	directDestroy = _directDestroy
	isDeletable = _isDeletable
	isPermanent = _isPermanent
    separate = _separate
	isStackable = _isStackable
	stackCount = _stackCount
	maxStackCount = _maxStackCount
	description = _description
	sprite = _sprite
}

function st_skill(_index, _cooldown, _mana, _energy, _sprite = sprNothingness, _cooldownmax, _code, _upgrade) constructor
{
	index = _index
	cooldown = _cooldown
    mana = _mana
    energy = _energy
	sprite = _sprite
	cooldownmax = _cooldownmax
	code = _code
	upgrade = _upgrade
}

function st_dialoguebox(_xx = 500, _yy = 250, _title, _text, _owner_assetName, _ownerID, _messageID, _duration = 5, _isDialogueMessage = false, _dialogueNo = undefined, _dialogueSize = undefined, _qKey = undefined, _buttonsArray = undefined) constructor
{
	xx = _xx
	yy = _yy
    title = _title
    text = _text
	owner_assetName = _owner_assetName
	ownerID = _ownerID
	messageID = _messageID
	duration = _duration
	isDialogueMessage = _isDialogueMessage
	dialogueNo = _dialogueNo
	dialogueSize = _dialogueSize
	qKey = _qKey
	buttonsArray = _buttonsArray
}

function st_speed(_xx = 0, _yy = 0) constructor {
	xx = _xx
	yy = _yy
}

function st_quest(_title, _isActive = false, _isAvailable = false, _code, _type, _description = "", _isCompleted = false, _receivedFrom, _targets, _targetCounts, _targetCounts_completed, _isAuto = true, _isDeletable = false, _isRepeatable = false, _requiredQuests, _requiredLevel = 1) constructor {
	title = _title
	isActive = _isActive
	isAvailable = _isAvailable
	code = _code
	type = _type
	description = _description
	isCompleted = _isCompleted
	receivedFrom = _receivedFrom
	targets = _targets
	targetCounts = _targetCounts
	targetCounts_completed = _targetCounts_completed
	isAuto = _isAuto
	isDeletable = _isDeletable
	isRepeatable = _isRepeatable
	requiredQuests = _requiredQuests
	requiredLevel = _requiredLevel
}