extends Area2D
const HIGHSCORE_PATH = "user://highscore.save"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalScript.waveFinish:
		print("wall is free now ")
		$wall.visible = false
		$wall/CollisionShape2D.disabled = true
		
#func checkHighscore(score: int) -> void:
	#var gm = %gamemanager
	#if score >gm.high_score:
		#gm.high_score = score
		#print("coin savev")
		#gm.save_high_score(score)


func _on_body_entered(body: Node2D) -> void:
	if body.name == "ahsoka":
		var saved_data = SaveSystem.load_game()
		if saved_data == null or not saved_data.has("coins"):
			print("No saved coins found in SaveSystem.")
			return
		
		var current_coins = saved_data["coins"]
		print("Current coins from SaveSystem: ", current_coins)
		
		var highscore_data = {"coins": 0}
		if FileAccess.file_exists(HIGHSCORE_PATH):
			var file = FileAccess.open(HIGHSCORE_PATH, FileAccess.READ)
			if file:
				var data_text = file.get_as_text()
				file.close()
				var json = JSON.new()
				var parsed = json.parse_string(data_text)

				if parsed is Dictionary:
					highscore_data = parsed
				else:
					print("Parsed data is not a dictionary.")
			else:
				print("Failed to open highscore file for reading.")
		else:
			highscore_data = {"coins": 0}

		var saved_coins = highscore_data.get("coins", 0)
		print("Highscore coins before comparison: ", saved_coins)

		if current_coins > saved_coins:
			highscore_data["coins"] = current_coins
			print("New highscore! Saving: ", current_coins)
		else:
			print("Highscore remains: ", saved_coins)

		var file = FileAccess.open(HIGHSCORE_PATH, FileAccess.WRITE)
		if file:
			var json = JSON.new()
			var json_string = json.stringify(highscore_data)
			file.store_string(json_string)
			file.close()
		else:
			print("Failed to open highscore file for writing.")

		print("Saved coins in highscore file: ", highscore_data["coins"])

		get_tree().change_scene_to_file("res://lvl_6.tscn")

	elif body.name == "ahsoka" and GlobalScript.waveFinish:
		$Label.text = "We don’t have the key to get out of here!"
		print("We don’t have the key to get out of here!")
	elif body.name == "ahsoka" and !GlobalScript.waveFinish and $"../key".key1:
		$Label.text = "You got a key but the wave is not yet finish"
		print("You got a key but the wave is not yet finish")
	elif body.name == "ahsoka":
		print("ahsoka just touched nothing more")
