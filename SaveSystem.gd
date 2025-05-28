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

#static func get_score():
	#var saved_data = load_game()
	#if saved_data == null:
		#print("No saved game found.")
		#return
	#
	#var current_coins = saved_data.get("coins", 0)
	#var high_score = 0
	#
	## Load current high score
	#if FileAccess.file_exists("user://highscore.save"):
		#var file = FileAccess.open("user://highscore.save", FileAccess.READ)
		#if file:
			#var data = file.get_as_text().strip_edges()
			#file.close()
			#if data.is_valid_integer():
				#high_score = int(data)
#
	## Compare and save if current score is higher
	#if current_coins > high_score:
		#print("New high score! Saving:", current_coins)
		#var file = FileAccess.open("user://highscore.save", FileAccess.WRITE)
		#if file:
			#file.store_string(str(current_coins))
			#file.close()
	#else:
		#print("High score remains:", high_score)
