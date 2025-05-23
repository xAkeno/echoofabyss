extends Node
@export var bonfire_id: String
@export var spawn_point: Node2D  # optional, a child node or position
@onready var save_sound: AudioStreamPlayer = $sfx_save
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var left = $ahsoka/CanvasLayer/left
	var right = $ahsoka/CanvasLayer/right
	var jump = $ahsoka/CanvasLayer/jump
	var attack = $ahsoka/CanvasLayer/attack
	var screen_size = get_viewport().get_visible_rect().size
	var margin = 32
	var base_size = 160 # Palakihin mo ito kung gusto mo mas malaki pa

	# Calculate dynamic button size based on screen width (e.g., 15% of width)
	var button_size = Vector2(screen_size.x * 0.15, screen_size.x * 0.15)

	# Scale and Position LEFT
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
	
	var current = get_tree().current_scene.scene_file_path
	var saved_pos = SaveSystem.load_game(current)
	if saved_pos:
		$ahsoka.global_position = saved_pos
		print("Loaded player at saved bonfire position.")
	$ahsoka.animation_tree.active = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_killzone_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "ahsoka":
		print("LOLOLO you dieesss")
		get_tree().call_deferred("reload_current_scene")
	pass # Replace with function body.


func _on_save_4_body_entered(body: Node2D) -> void:
	var current = get_tree().current_scene.scene_file_path
	if body.name == "ahsoka":
		print("Resting at bonfire: ", bonfire_id)
		$save4/Label.text = "Game Saved"
		$save4/Label.show()  # Optional, in case it's hidden
		save_sound.play()
		print("save sound active")
		SaveSystem.save_game(bonfire_id,$ahsoka.global_position,current)
		await get_tree().create_timer(2.0).timeout  # Wait 2 seconds

		$save4/Label.hide()
	pass # Replace with function body.


func _on_save_5_body_entered(body: Node2D) -> void:
	var current = get_tree().current_scene.scene_file_path
	if body.name == "ahsoka":
		print("Resting at bonfire: ", bonfire_id)
		$save5/Label.text = "Game Saved"
		$save5/Label.show()  # Optional, in case it's hidden
		save_sound.play()
		print("save sound active")
		SaveSystem.save_game(bonfire_id,$ahsoka.global_position,current)
		await get_tree().create_timer(2.0).timeout  # Wait 2 seconds

		$save5/Label.hide()
	pass # Replace with function body.
