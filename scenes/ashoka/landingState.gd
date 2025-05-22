extends State
class_name landingState
@export var ground_state: State
@export var landing_animation_name :String = "landing"

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if(anim_name == landing_animation_name):
		next_state = ground_state
