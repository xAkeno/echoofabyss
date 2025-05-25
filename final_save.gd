extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "ahsoka" and GlobalScript.waveFinish and $"../key".key1:
		get_tree().change_scene_to_file("res://lvl_6.tscn")
	elif body.name == "ahsoka" and GlobalScript.waveFinish:
		print("Your finish the wave but have no key")
	elif body.name == "ahsoka" and !GlobalScript.waveFinish and $"../key".key1:
		print("Your got a key but the wave is not yet finish")
	elif body.name == "ahsoka":
		print("ahsoka just touch nothing more")
