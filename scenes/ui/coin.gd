extends Area2D
@onready var game_manager: Node = %gamemanager
@onready var coin_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var coin_collision: CollisionShape2D = $CollisionShape2D
@onready var coin_sound: AudioStreamPlayer2D = $coin_sound

func _on_body_entered(body: Node2D) -> void:
		coin_sound.play()	
		coin_sprite.visible = false
		coin_collision.set_deferred("disabled", true)
		await get_tree().create_timer(coin_sound.stream.get_length()).timeout
		
		game_manager.add_points()
		queue_free()

	
