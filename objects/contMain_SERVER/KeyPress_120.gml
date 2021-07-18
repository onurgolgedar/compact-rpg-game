db_save_table(global.DB_SRV_TABLE_accounts)
db_save_table(global.DB_SRV_TABLE_wallets)

var ds_size = db_get_table_size(global.DB_SRV_TABLE_onlineAccounts)
for (var i = 0; i < ds_size; i++) {
	var _row = db_get_row_by_index(global.DB_SRV_TABLE_onlineAccounts, i)
	var accountID = _row[? ONLINEACCOUNTS_ACCID_SERVER]
	
	var boxes_SERVER = global.playerBoxes[? accountID]
	var _grid = ds_grid_create(global.bc_hor_COMMON*global.pageCount_COMMON, global.bc_ver_COMMON+2)
	for (var k = 0; k < global.bc_hor_COMMON*global.pageCount_COMMON; k++) {
		for (var d = 0; d < global.bc_ver_COMMON+2; d++) {
			var box = ds_grid_get(boxes_SERVER, k, d)
		
			ds_grid_set(_grid, k, d, json_stringify(box))
		}
	}
	ini_open("Boxes.dbfile")
		ini_write_string("Boxes", accountID, ds_grid_write(_grid))
	ini_close()
	ds_grid_destroy(_grid)
}