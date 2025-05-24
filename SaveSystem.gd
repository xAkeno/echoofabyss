extends Node

# SaveSystem.gd
var save_data = {}

# SaveSystem.gd
static func save_game(bonfire_id: String, position: Vector2, current: String, coins: int):
	var save_data = {
		"bonfire_id": bonfire_id,
		"position": position,
		"scene": current,
		"coins": coins
	}
	var file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	file.store_var(save_data)
	file.close()


# SaveSystem.gd
static func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return null
	var file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var data = file.get_var()
	file.close()
	return data
	
static func clear_save():
	var path = "user://savegame.save"
	if FileAccess.file_exists(path):
		var dir = DirAccess.open("user://")
		if dir:
			var err = dir.remove("savegame.save")
			if err != OK:
				push_error("Failed to delete save file")
			else:
				print("Save file cleared successfully.")
		else:
			push_error("Failed to open user directory")
	else:
		print("No save file to clear.")
