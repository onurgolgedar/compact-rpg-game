function show_message_client(messageID, owner = id,  dialogueNo = 1, answerBefore = -1) {
	net_client_send(_CODE_DIALOGUE, object_get_name(owner.object_index)+"|"+string(messageID)+"|"+string(dialogueNo)+"|"+string(answerBefore)+"|"+string(owner), BUFFER_TYPE_STRING)
}