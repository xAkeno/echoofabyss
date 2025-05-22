extends State
class_name groundState

@export var jump_velocity:float = -400.0
@export var air_state: State 
@export var jump_animation :String = "jump"
@export var attack_state: State
@export var attack_animation:String = "attack_1"
@onready var slash: AudioStreamPlayer = get_node("../../sfx_attack")
@onready var jump_sound: AudioStreamPlayer = get_node("../../sfx_jump")
func state_process(delta):
	if(!ashoka.is_on_floor()):
		next_state = air_state

func state_input(event: InputEvent):
	if(event.is_action_pressed("jump_mobile")):
		if jump_sound:
			print("jumpinh")
			jump_sound.play()
			jump()
		else:
			print("⚠️ jump is null – check AudioStreamPlayer path")
	if(event.is_action_pressed("attack_mobile")):
		if slash:
			slash.pitch_scale = randf_range(0.9, 1.1)
			print("slashing")
			slash.play()
		else:
			print("⚠️ slash is null – check AudioStreamPlayer path")
		attack()
		
func jump():
	ashoka.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)
func attack():
	next_state = attack_state
	playback.travel(attack_animation)
