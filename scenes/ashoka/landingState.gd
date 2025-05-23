extends State
class_name landingState
@export var ground_state: State
@export var landing_animation_name :String = "landing"
@onready var landing: AudioStreamPlayer = get_node("../../sfx_land")
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == landing_animation_name):
		if landing:
			landing.pitch_scale = randf_range(0.9, 1.1)
			print("landing sound")
			landing.play()
		else:
			print("⚠️ landing sounds is null – check AudioStreamPlayer path")
		next_state = ground_state
