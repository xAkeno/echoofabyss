extends Node
# Step tracker
var step = 0

# Reference to the Label node
@onready var label = $InstructionLabel
@onready var label2 = $Label
@export var bonfire_id: String
@export var spawn_point: Node2D  # optional, a child node or position
@export var dialog_key: String
var area_active = false
var attack_count = 0
var attack_timer = 0.0
const DOUBLE_ATTACK_MAX_TIME = 0.4
@onready var save_sound: AudioStreamPlayer = $sfx_save
func _ready():
	var left = $ahsoka/CanvasLayer/left
	var right = $ahsoka/CanvasLayer/right
	var jump = $ahsoka/CanvasLayer/jump
	var attack = $ahsoka/CanvasLayer/attack
	var screen_size = get_viewport().get_visible_rect().size
	var margin = 32
	var base_size = 160 # Palakihin mo ito kung gusto mo mas malaki pa

	# Calculate dynamic button size based on screen width (e.g., 15% of width)
	var button_size = Vector2(screen_size.x * 0.15, screen_size.x * 0.15)
#
	## Scale and Position LEFT
	left.scale = button_size / left.texture_normal.get_size()
	left.position = Vector2(margin, screen_size.y - button_size.y - margin)

	# Scale and Position RIGHT (katabi ng left)
	right.scale = button_size / right.texture_normal.get_size()
	right.position = Vector2(left.position.x + button_size.x + margin, left.position.y)

	# Scale and Position JUMP (right side of screen)
	jump.scale = button_size / jump.texture_normal.get_size()
	jump.position = Vector2(screen_size.x - button_size.x * 2 - margin * 2, screen_size.y - button_size.y - margin)

	# Scale and Position ATTACK (far right)
	attack.scale = button_size / attack.texture_normal.get_size()
	attack.position = Vector2(screen_size.x - button_size.x - margin, screen_size.y - button_size.y - margin)
	
	##
	var current = get_tree().current_scene.scene_file_path
	var saved_pos = SaveSystem.load_game(current)
	if saved_pos:
		$ahsoka.global_position = saved_pos
		print("Loaded player at saved bonfire position.")
	$ahsoka.animation_tree.active = true
	label.text = "Press D to move right"

func _process(delta):
	match step:
		0:
			if Input.is_action_just_pressed("right_mobile"):  # You can define "move_right" as 'd'
				label.text = "Press A to move left"
				step += 1
		1:
			if Input.is_action_just_pressed("left_mobile"):  # You can define "move_left" as 'a'
				label.text = "Press Space to jump"
				step += 1
		2:
			if Input.is_action_just_pressed("jump_mobile"):  # You can define "jump" as 'space'
				label.text = "Now try jumping on the other side"
				step += 1


func _on_otherside_main_body_entered(body: Node2D) -> void:
	label.hide()
	pass # Replace with function body.


func _on_otherside_main_2_body_entered(body: Node2D) -> void:
	label2.text = "Now Lets try double jumping just press double space."
	pass # Replace with function body.


func _on_killzone_body_entered(body: Node2D) -> void:
	if body.name == "ahsoka":
		get_tree().call_deferred("reload_current_scene")
		print("dead")
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	var current = get_tree().current_scene.scene_file_path
	if body.name == "ahsoka":
		print("Resting at bonfire: ", bonfire_id)
		SaveSystem.save_game(bonfire_id,$ahsoka.global_position,current)

	pass # Replace with function body.
	


func _on_save_2_body_entered(body: Node2D) -> void:
	var current = get_tree().current_scene.scene_file_path
	if body.name == "ahsoka":
		print("Resting at bonfire: ", bonfire_id)
		$save2/Label.text = "Game Saved"
		save_sound.play()
		print("save sound active")
		$save2/Label.show()  # Optional, in case it's hidden
		SaveSystem.save_game(bonfire_id,$ahsoka.global_position,current)
		#await get_tree().create_timer(2.0).timeout  # Wait 2 seconds
#
		#$save2/Label.hide()
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("skip"):
		print("ui_accept pressed and area active!")
		SignalBus.emit_signal("display_dialog", dialog_key)
	if event.is_action_pressed("attack_mobile"):
		$Area2D/Label2.text = "Now try attacking faster"
		attack_count += 1
		attack_timer = 0.0  # reset timer
		if attack_count == 2:
			$Area2D/Label2.text = "Nice! Go save your mother"
			attack_count = 0
			attack_timer = 0.0
			

func _on_dialog_area_area_entered(area: Area2D) -> void:
	print("hhh")
	var dialog_area_node = $DialogArea
	print("DialogArea dialog_key is: '", dialog_area_node.dialog_key, "'")
	
	if dialog_area_node.dialog_key != "":
		SignalBus.emit_signal("display_dialog", dialog_area_node.dialog_key)
	else:
		push_error("DialogArea node is missing a valid dialog_key.")

func _on_dialog_area_area_exited(area: Area2D) -> void:
	print("hi")
	pass # Replace with function body.


func _on_beginning_area_entered(area: Area2D) -> void:
	var dialog_area_node = $beginning
	print("DialogArea dialog_key is: '", dialog_area_node.dialog_key, "'")
	
	if dialog_area_node.dialog_key != "":
		SignalBus.emit_signal("display_dialog", dialog_area_node.dialog_key)
	else:
		push_error("DialogArea node is missing a valid dialog_key.")


func _on_beginning_area_exited(area: Area2D) -> void:
	$Area2D/Label2.show()
	pass # Replace with function body.


func _on_dialog_area_body_entered(body: Node2D) -> void:
	print("hhh")
	pass # Replace with function body.
