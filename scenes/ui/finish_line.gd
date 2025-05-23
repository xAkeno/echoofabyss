extends Area2D
@onready var finish_sound: AudioStreamPlayer = get_node("../sfx_finish")
#@export var target_level :PackedScene

func _on_body_entered(body: Node2D) -> void:
	if(body.name == "ahsoka"):
		print("hello")
		finish_sound.play()
		print("finish sound active")
		var current = get_tree().current_scene.scene_file_path
		print(current)
		var next = current.to_int() + 1
		var path = "res://scenes/levels/" + "lvl_" +str(next)+ ".tscn"
		get_tree().change_scene_to_file(path)
		print(path)
