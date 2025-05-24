extends CharacterBody2D
class_name FrogEnemy

var max_health : int = 80
var min_health :int = 0
var health : int =  80

var speed = 40
@onready var animatedsprite = $AnimatedSprite2D
var damage_to_deal : int = 10
var dir : Vector2
var is_chasing : bool

var player 

var dead : bool
var is_attacking : bool
var is_taking_damage : bool
var allowed_to_take_damage : bool 
var knockback : int = -150
const gravity : int = 900

var is_roaming : bool
var damage_taken : int
var damage_done : int

var points_for_kill : int = 250

@export var frog_scene : PackedScene

func _ready():
	dead = false
	is_chasing = true
	is_attacking = false
	is_taking_damage = false
	allowed_to_take_damage = true
	is_roaming = true
	player = GlobalScript.playerBody
	
func _process(delta):
	#if GlobalScript.playerAlive:
		#is_chasing = true
	#elif !GlobalScript.playerAlive:
		#is_chasing = false
	if !is_on_floor():
		velocity.y += gravity
	move(delta)
	
	handle_animation()
	
		
func move(delta):
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
			animatedsprite.flip_h = false
		elif dir.x == -1:
			animatedsprite.flip_h = true
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


func _on_frog_hit_box_area_entered(area):
	#print("attack np")
	if area == GlobalScript.playerDamageZone:
		damage_taken = GlobalScript.playerDamage
		if allowed_to_take_damage:
			taking_damage(damage_taken)
		
func taking_damage(damage):
	if !dead:
		health -= damage
		is_taking_damage = true
		print("current health : ",health)
		if health <= 0:
			health = 0
			dead = true
		damage_cooldown(1.5)

func damage_cooldown(wait_time):
	allowed_to_take_damage = false
	await get_tree().create_timer(wait_time).timeout
	allowed_to_take_damage = true
	is_taking_damage = false


func _on_frog_damage_zone_body_entered(body):
	if body == GlobalScript.playerBody:
		print("touch2")
		is_attacking = true
		GlobalScript.frogDamage = damage_to_deal
		
