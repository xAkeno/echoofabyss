extends Area2D
@onready var finish_sound: AudioStreamPlayer = get_node("../sfx_finish")
@export var bonfire_id: String
@export var spawn_point: Node2D  # optional, a child node or position

#@export var target_level :PackedScene

func _on_body_entered(body: Node2D) -> void:
	var key_node = get_node("../key")
	
	if body.name == "ahsoka" and key_node.key1:
		print("hello")
		finish_sound.play()
		print("finish sound active")
		var current = get_tree().current_scene.scene_file_path
		var next = current.get_file().get_basename().split("_")[1].to_int() + 1  # safer parsing lvl number
		var path = "res://scenes/levels/lvl_" + str(next) + ".tscn"
		print(path)
		var gm = %gamemanager  # Access the global GameManager
		print("Resting at bonfire: ", bonfire_id)
		var pos = "212.0,584.0"
		var split = pos.split(",")
		var vec = Vector2(split[0].to_float(), split[1].to_float())

		SaveSystem.save_game(
			bonfire_id,
			vec,
			current,
			gm.points
		)
		key_node.key1 = false
		get_tree().change_scene_to_file(path)
	elif body.name == "ahsoka":
		$Label.text = "Cannot open key needed"
		print("there is not key")
