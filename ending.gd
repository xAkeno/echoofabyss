extends Node

func _ready():
	# Optional: Fade-in or sound logic
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		get_tree().change_scene_to_file("res://scenes/levels/main_menyu.tscn")  # Update path to your actual main menu scene
