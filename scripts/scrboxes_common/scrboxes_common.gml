function box_create_COMMON(item = undefined, isForQuest = false, count = 1) {
	if (item == undefined)
		return { item: undefined, tag: { isForQuest: false }, count: 0 }
	else
		return { item: item_copy_COMMON(item), tag: { isForQuest: isForQuest }, count: count }
}

function box_get_confirmation_number_COMMON(box) {
	if (box == undefined)
		return "--"
	else
		return string(box.tag.isForQuest)+string(item_get_confirmation_number_COMMON(box.item))
}