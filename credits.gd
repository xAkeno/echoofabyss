extends CanvasLayer

var should_change_scene := false

func _ready():
	$AnimationPlayer.play("dissolve")  # This fades in when scene starts
	$AudioStreamPlayer.stream.loop = true  # Ensure the audio stream loops
	$AudioStreamPlayer.play()

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		$AnimationPlayer.play_backwards("dissolve")
		should_change_scene = true  # Flag to change scene after fade

#func _on_AnimationPlayer_animation_finished(anim_name):
	#if anim_name == "dissolve" and should_change_scene:
		#get_tree().change_scene_to_file("res://scenes/levels/main_menyu.tscn")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "dissolve" and should_change_scene:
		get_tree().change_scene_to_file("res://scenes/levels/main_menyu.tscn")
