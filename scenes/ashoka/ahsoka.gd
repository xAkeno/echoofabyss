extends CharacterBody2D

@export var  speed: float = 300.0
var has_double_jumped: bool = false
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: ashokaStateMachine = $ashokaStateMachine
@onready var sword: Area2D = $playerDamageZone
var can_take_damage := false
var is_inside_enemy_hitbox := false
var is_allowed_to_take_damage : bool
var health = 100
var damage : int 
var is_alive : bool
var max_health = 100
var min_health = 0

func _ready():	
	GlobalScript.playerDamageZone = sword
	GlobalScript.playerDamage = 20
	GlobalScript.playerBody = self
	GlobalScript.playerAlive = true
	animation_tree.active = true
	is_allowed_to_take_damage = true
	is_alive = true
	

func get_direction() -> float:
	return Input.get_action_strength("right_mobile") - Input.get_action_strength("left_mobile")

func check_hitbox():
	var area_hitbox = $playerHitBox.get_overlapping_areas()
	if area_hitbox:
		var hitbox = area_hitbox.front()
		if hitbox.get_parent() is Batenemy:
			damage = GlobalScript.batDamage
		elif hitbox.get_parent() is FrogEnemy:
			damage = GlobalScript.frogDamage
		elif hitbox.get_parent() is botoEnemy:
			await get_tree().create_timer(0.8).timeout
			
			# Re-check if the player is still overlapping with a botoEnemy
			var recheck_hitbox = $playerHitBox.get_overlapping_areas()
			for area in recheck_hitbox:
				if area.get_parent() is botoEnemy:
					damage = GlobalScript.botoDamage
					break
		elif hitbox.get_parent() is minaEnemy:
			await get_tree().create_timer(0.8).timeout
			# Re-check if the player is still overlapping with a botoEnemy
			var recheck_hitbox = $playerHitBox.get_overlapping_areas()
			for area in recheck_hitbox:
				if area.get_parent() is minaEnemy:
					damage = GlobalScript.minaDamage
					break
	
	if is_allowed_to_take_damage:
		take_damage(damage)
		#print("current health is:", health)

func take_damage(damage):
	print(self,health)
	if health < 0:
		health = 0
		print("dead")
		get_tree().reload_current_scene()
		is_alive = false
	if damage != 0: 
		if health > 0:
			health -= damage
			$sfx_damage.play()
			$ahsokadamagable.damage(damage)
			take_damage_cooldown(1.5)
			
func take_damage_cooldown(wait_time):
	is_allowed_to_take_damage = false
	await get_tree().create_timer(wait_time).timeout
	is_allowed_to_take_damage = true
	damage = 0	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_vector("left_mobile", "right_mobile" , "ui_up", "ui_down")
	
	if Input.is_action_just_pressed("test"):
		$ahsokadamagable.damage(5)
		pass
	
	if direction and state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	if is_alive:
		check_hitbox()
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


func _on_trap_body_entered(body: Node2D) -> void:
	print("DAMAGED BY TRAP")
	pass # Replace with function body.


func _on_player_hit_box_area_entered(area: Area2D) -> void:
	if area.name == "":
		is_inside_enemy_hitbox = true
		await get_tree().create_timer(0.5).timeout
		#$ahsokadamagable.damage(50)
		#check_hitbox()
