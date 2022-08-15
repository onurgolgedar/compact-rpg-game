function show_message_client(messageID, owner = real(id),  dialogueNo = 1, answerBefore = -1) {
	net_client_send(_CODE_DIALOGUE, json_stringify({ owner_assetName: object_get_name(owner.object_index), ownerID: owner, messageID: messageID, dialogueNo: dialogueNo, answerBefore: answerBefore }), BUFFER_TYPE_STRING)
}