function chat(_title, _txt, _color) {
	ds_list_add(global.chatHistory, { title: _title, txt: _txt, color: _color })
	var ds_size = ds_list_size(global.chatHistory)
	if (ds_size > 9) {
		delete global.chatHistory[| 0]
		ds_list_delete(global.chatHistory, 0)
	}
}