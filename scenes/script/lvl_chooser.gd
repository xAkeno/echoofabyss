extends Control


func _ready() -> void:
	$AudioStreamPlayer.stream.loop = true  # Ensure the audio stream loops
	$AudioStreamPlayer.play()
	print("sound on2")

func _on_lvl_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/lvl_1.tscn")


func _on_lvl_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/lvl_2.tscn")


func _on_lvl_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/lvl_3.tscn")


func _on_lvl_4_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/lvl_4.tscn")


func _on_lvl_5_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/lvl_5.tscn")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/main_menyu.tscn")
