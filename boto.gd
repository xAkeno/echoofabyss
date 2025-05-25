extends CharacterBody2D
class_name botoEnemy

var max_health : int = 80
var min_health :int = 0
var health : int =  80

var speed = 50
@onready var animatedsprite = $AnimatedSprite2D
var damage_to_deal : int = 5
var dir : Vector2
var is_chasing : bool

var player 

var dead : bool
var is_attacking : bool
var is_taking_damage : bool
var allowed_to_take_damage : bool 
var knockback : int = -200
const gravity : int = 900

var is_roaming : bool
var damage_taken : int
var damage_done : int

var points_for_kill : int = 250
var player_in_boto_damage_area: bool = false

@export var boto_scene : PackedScene
@onready var ray = $RayCast2D
@onready var ray2 = $RayCast2D2

func _ready():
	dead = false
	is_chasing = false
	is_attacking = false
	is_taking_damage = false
	allowed_to_take_damage = true
	is_roaming = true
	player = GlobalScript.playerBody
	
func _process(delta):
	if GlobalScript.playerAlive and (ray.is_colliding() or ray2.is_colliding()):
		var collider = ray.get_collider()
		var collider2 = ray2.get_collider()
			
		if collider == GlobalScript.playerBody or collider2 == GlobalScript.playerBody:
			is_chasing = true
	elif !GlobalScript.playerAlive:
		is_chasing = false
	if !is_on_floor():
		velocity.y += gravity
	move(delta)
	
	handle_animation()
	
		
func move(delta):
	player = GlobalScript.playerBody
	if !dead and is_roaming:
		if !is_chasing:
			velocity += dir * speed * delta
		elif is_chasing and !is_taking_damage:
			var dir_to_player = position.direction_to(player.position) * speed
			velocity.x = dir_to_player.x
			dir.x = abs(velocity.x)/velocity.x
		elif is_taking_damage:
			var knockback_dir = position.direction_to(player.position) * knockback
			velocity.x = knockback_dir.x
		move_and_slide()
	elif dead:
		velocity.x = 0
		
func handle_animation():
	if !dead and !is_attacking and !is_taking_damage:
		animatedsprite.play("run")
		if dir.x == 1:
			animatedsprite.flip_h = true
		elif dir.x == -1:
			animatedsprite.flip_h = false
	elif is_taking_damage:
		animatedsprite.play("hurt")
		await get_tree().create_timer(0.4).timeout
		is_taking_damage = false
	elif is_attacking:
		animatedsprite.play("attack")
		await get_tree().create_timer(1).timeout
		is_attacking = false
	elif dead and is_roaming:
		is_roaming = false
		animatedsprite.play("death")
		await get_tree().create_timer(1).timeout
		GlobalScript.current_score +=points_for_kill
		self.queue_free()

func _on_direction_timer_timeout():
	$DirectionTimer.wait_time = chose([0.5,1,1.6])
	dir = chose([Vector2.RIGHT,Vector2.LEFT])
	velocity.x = 0
	
func chose(array):
	array.shuffle()
	return array.front()

		
func taking_damage(damage):
	if !dead:
		health -= damage
		is_taking_damage = true
		$sfx_damage_enemy.play()
		if health <= 0:
			health = 0
			dead = true
		damage_cooldown(1)

func damage_cooldown(wait_time):
	allowed_to_take_damage = false
	await get_tree().create_timer(wait_time).timeout
	allowed_to_take_damage = true
	is_taking_damage = false

func _on_boto_hit_box_area_entered(area):
	#print("attack np")
	if area == GlobalScript.playerDamageZone:
		damage_taken = GlobalScript.playerDamage
		if allowed_to_take_damage:
			taking_damage(damage_taken)

func _on_boto_damage_zone_body_entered(body):
	if body == GlobalScript.playerBody:
		player_in_boto_damage_area = true
		if !is_attacking:
			attack_repeat_loop()
		GlobalScript.botoDamage = damage_to_deal
		
func _on_boto_damage_zone_body_exited(body: Node2D) -> void:
	if body == GlobalScript.playerBody:
		player_in_boto_damage_area = false
	
func attack_repeat_loop():
	is_attacking = true
	animatedsprite.play("attack")
	await get_tree().create_timer(1).timeout
	is_attacking = false
	
	if player_in_boto_damage_area:
		attack_repeat_loop()
