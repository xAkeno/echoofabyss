extends Control
#@onready var game_manager: Node = %gamemanager

func _ready() -> void:
	$AudioStreamPlayer.stream.loop = true  # Ensure the audio stream loops
	$AudioStreamPlayer.play()
	SaveSystem.clear_save()
	var high_score = 0
	if FileAccess.file_exists("user://highscore.save"):
		var file = FileAccess.open("user://highscore.save", FileAccess.READ)
		var content = file.get_as_text()
		var json = JSON.new()
		var result = json.parse_string(content)

		if result is Dictionary and result.has("coins"):
			var coins = result["coins"]
			print("Coins value: ", coins)
			$highscore.text = "Highest score: " + str(coins)
		else:
			print("Failed to parse or 'coins' not found.")
	print("sound on")
	
	print("sound on")

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/lvl_chooser.tscn")


func _on_idk_pressed() -> void:
	get_tree().change_scene_to_file("res://credits.tscn")
	#SaveSystem.clear_save()
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
	
