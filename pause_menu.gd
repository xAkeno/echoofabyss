extends Control

func resume():
	$AnimationPlayer.play("RESET")
	get_tree().paused = false
	print(get_tree().paused)
	
func pause():
	$AnimationPlayer.play("blur")
	get_tree().paused = true
	print(get_tree().paused)
	
	
func restart():
	get_tree().reload_current_scene()
	
func quit():
	get_tree().quit()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_resume_pressed() -> void:
	resume()
	pass # Replace with function body.


func _on_menu_pressed() -> void:
	
	pass # Replace with function body.


func _on_restart_pressed() -> void:
	restart()
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	quit()
	pass # Replace with function body.
