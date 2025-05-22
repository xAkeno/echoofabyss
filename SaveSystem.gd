extends Node

const SAVE_PATH = "user://save_data.cfg"

func save_game(bonfire_id: String, position: Vector2, current: String):
	var config = ConfigFile.new()
	config.set_value("Save", "bonfire_id", bonfire_id)
	config.set_value("Save", "position_x", position.x)
	config.set_value("Save", "position_y", position.y)
	config.set_value("Save","level",current)
	config.save(SAVE_PATH)
	print("Game saved at bonfire: ", bonfire_id)

func load_game(current: String):
	var config = ConfigFile.new()
	var err = config.load(SAVE_PATH)
	var saved_level = config.get_value("Save", "level", "")
	if saved_level != current:
		return null  # Current level doesn't match saved level
	var pos = Vector2(
		config.get_value("Save", "position_x", 0),
		config.get_value("Save", "position_y", 0)
	)
	return pos
