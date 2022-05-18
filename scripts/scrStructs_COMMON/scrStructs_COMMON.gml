function dialogueButton(_text, _image = undefined, _value = undefined) constructor
{
    text = _text
    image = _image
	hover = false
	value = _value
}

function location(_name, _code, _spawn_x, _spawn_y) constructor
{
    name = _name
    code = _code
	spawn_x = _spawn_x
	spawn_y = _spawn_y
}

function effectBox(_code, _name, _owner, _creator, _level = -1, _maxTime = -1, _directDestroy = true, _isDeletable = true, _isPermanent = false, _separate = false, _isStackable = false, _stackCount = 1, _maxStackCount = 1, _description = "", _sprite = "sprNothingness") constructor
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
