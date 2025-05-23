extends Control


func _ready() -> void:
	$AudioStreamPlayer.stream.loop = true  # Ensure the audio stream loops
	$AudioStreamPlayer.play()
	print("sound on")

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/lvl_chooser.tscn")


func _on_idk_pressed() -> void:
	SaveSystem.clear_save()
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
