extends State
@export var return_animation_node:String ="move"
@export var attack_1_name :String = "attack_1"
@export var attack_2_name :String = "attack_2"
@export var return_state: State 
@onready var timer: Timer = $Timer
@export var attack_2_node : String = "attack2"
@onready var sword: Area2D = $"../../playerDamageZone"
@onready var slash: AudioStreamPlayer = get_node("../../sfx_attack")
var current_damage_dealt : int

func state_input(event: InputEvent):

	if(event.is_action_pressed("attack_mobile")):
		timer.start()
		if slash:
			slash.pitch_scale = randf_range(0.9, 1.1)
			print("slashing double")
			GlobalScript.playerDamage = 1000
			slash.play()
		else:
			print("⚠️ slash is null – check AudioStreamPlayer path")
		
	

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	var damage_zone_collision = sword.get_node("dmgZone")
	var wait_time: float	
	
	if(anim_name == attack_1_name ):
		if(timer.is_stopped()):
			next_state = return_state
			playback.travel(return_animation_node)
			GlobalScript.playerDamage = 1000
			wait_time = 0.2
		else:
			playback.travel(attack_2_node)
		
		
	if( anim_name == attack_2_name):
		next_state = return_state
		wait_time = 0.3
		playback.travel(return_animation_node)
		
	damage_zone_collision.set_deferred("disabled", false)	
	await get_tree().create_timer(wait_time).timeout
	damage_zone_collision.set_deferred("disabled", true)
