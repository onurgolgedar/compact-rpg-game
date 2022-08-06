save_SERVER()
with (objPlayer_SERVER) {
	hp = maxHp
	mana = maxMana
	energy = maxEnergy
	
	db_set_row_value(global.DB_SRV_TABLE_players, socketID, PLAYERS_HP_SERVER, hp)
	db_set_row_value(global.DB_SRV_TABLE_players, socketID, PLAYERS_MANA_SERVER, mana)
	db_set_row_value(global.DB_SRV_TABLE_players, socketID, PLAYERS_ENERGY_SERVER, energy)
}