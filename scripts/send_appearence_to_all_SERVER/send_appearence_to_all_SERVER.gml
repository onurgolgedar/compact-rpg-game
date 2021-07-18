function send_appearence_to_all_SERVER(socketID, socketID_receiver) {
	var box = get_active_box_SERVER(socketID, ITEMTYPE_SWORD)
	var weaponSprite = box.item == undefined ? sprite_get_name(sprNothingness) : sprite_get_name(box.item.sprite)
	
	box = get_active_box_SERVER(socketID, ITEMTYPE_CLOTHES)
	var clothesSprite = box.item == undefined ? sprite_get_name(sprNothingness) : sprite_get_name(box.item.sprite)
	
	net_server_send(socketID_receiver, CODE_APPEARENCE, string(socketID)+"|"+weaponSprite+"|"+clothesSprite, BUFFER_TYPE_STRING)
}