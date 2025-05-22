extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("dieee")
	get_tree().reload_current_scene()
