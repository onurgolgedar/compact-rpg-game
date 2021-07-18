if (!is_alive() or objPlayer.stunned)
	exit

if (objPlayer.skills[0].code != undefined)
	net_client_send(objPlayer.skills[0].code)