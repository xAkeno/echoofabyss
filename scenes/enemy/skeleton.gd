extends CharacterBody2D  # Ensure it's a Node-derived class

@export var ahsoka : CharacterBody2D
@export var speed : int = 50
@export var CHASE_SPEED : int = 150
@export var ACCELERATION : int = 300
const GRAVITY = 1000
const FOLLOW_DISTANCE = 100  # Distance within which enemy follows player

@onready var raycast_horizontal: RayCast2D = $AnimatedSprite2D/raycast_horizontal
@onready var skeleton: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast_down: RayCast2D = $AnimatedSprite2D/raycast_down
@onready var timer: Timer = $Timer

var direction : Vector2 = Vector2(1, 0)
var left_bounds : Vector2
var right_bounds : Vector2

enum States {
	Wander,
	Chase,
	Attack
}
var current_state = States.Wander

func _ready():
	left_bounds = position - Vector2(50, 0)
	right_bounds = position + Vector2(50, 0)

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_movement(delta)
	change_direction()
	look_for_ahsoka()

func look_for_ahsoka():
	if ahsoka and position.distance_to(ahsoka.position) < FOLLOW_DISTANCE:
		chase_player()
	else:
		stop_chase()

func chase_player() -> void:
	timer.stop()
	current_state = States.Chase

func stop_chase() -> void:
	if timer.time_left <= 0:
		timer.start()
		current_state = States.Wander

func handle_movement(delta: float) -> void:
	var target_speed = speed if current_state == States.Wander else CHASE_SPEED
	
	if current_state == States.Chase:
		direction = (ahsoka.position - position).normalized()
	else:
		# Wander within patrol bounds
		if direction.x > 0 and position.x >= right_bounds.x - 5:
			direction.x = -1
		elif direction.x < 0 and position.x <= left_bounds.x + 5:
			direction.x = 1

	velocity = velocity.move_toward(direction * target_speed, ACCELERATION * delta)
	move_and_slide()

func change_direction() -> void:
	if not raycast_down.is_colliding():
		direction.x *= -1
		skeleton.flip_h = direction.x < 0
		raycast_horizontal.target_position.x *= -1
		raycast_down.target_position.x *= -1

func handle_gravity(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

func _on_timer_timeout() -> void:
	current_state = States.Wander
