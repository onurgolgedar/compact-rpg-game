function show_message_client(messageID, owner = id,  dialogueNo = 1, answerBefore = -1) {
	net_client_send(_CODE_DIALOGUE, json_stringify({ owner_assetName: object_get_name(owner.object_index), messageID: messageID, dialogueNo: dialogueNo, answerBefore: answerBefore, owner: owner }), BUFFER_TYPE_STRING)
}