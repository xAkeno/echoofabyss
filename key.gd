extends Area2D
@onready var game_manager: Node = %gamemanager
var key1 = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.name == "ahsoka":
		$AnimatedSprite2D.visible = false
		print("key received")
		$AudioStreamPlayer.play()
		game_manager.update_key()
		key1 = true
	pass # Replace with function body.
