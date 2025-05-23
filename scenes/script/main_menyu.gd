extends Control



func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/lvl_chooser.tscn")


func _on_idk_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
