extends State
class_name AirState

@export var landing_state: State 
@export var double_jump_velocity :float = -300.0
@export var double_jump_animation: String = "jump_double"
@export var landing_animation: String ="landing"
@onready var jump_sound: AudioStreamPlayer = get_node("../../sfx_jump")

var has_double_jumped =  false

func state_process(delta):
	if(ashoka.is_on_floor()):
		next_state = landing_state

func on_exit():
	if(next_state ==landing_state):
		playback.travel(landing_animation)
		has_double_jumped =  false

func state_input(event: InputEvent):
	if(event.is_action_pressed("jump_mobile") and  !has_double_jumped):
		if jump_sound:
			jump_sound.pitch_scale = randf_range(0.9, 1.1)
			print("jumpinh double")
			jump_sound.play()
			double_jump()
		else:
			print("⚠️ jump is null – check AudioStreamPlayer path")
	
func double_jump():
	ashoka.velocity.y = double_jump_velocity
	playback.travel(double_jump_animation)
	has_double_jumped = true
	
