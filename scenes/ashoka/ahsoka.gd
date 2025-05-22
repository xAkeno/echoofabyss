extends CharacterBody2D

@export var  speed: float = 300.0
var has_double_jumped: bool = false
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: ashokaStateMachine = $ashokaStateMachine
@onready var sword: Area2D = $sword

func _ready():
	animation_tree.active = true

func get_direction() -> float:
	return Input.get_action_strength("right_mobile") - Input.get_action_strength("left_mobile")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_vector("left_mobile", "right_mobile" , "ui_up", "ui_down")
	
	if direction and state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	animation_handler(direction)	
	#
func animation_handler(direction):
	animation_tree.set("parameters/move/blend_position", direction.x)
	flip_sprite(direction)	
			
func flip_sprite(direction):
	if direction.x > 0:
		sprite.flip_h =  false
		sword.scale.x = 1
		
	elif direction.x <0:
		sprite.flip_h =  true	
		sword.scale.x = -1
#func jump():		
	#velocity.y = jump_velocity
	##sprite.play("jump_start")
	#animation_locked = true
		
#
#func _on_sprite_animation_finished() -> void:
	#if(["jump_start", "jump_end", "double_jump"].has(sprite.animation)):
		#animation_locked =false
		#
