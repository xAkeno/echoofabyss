extends AnimatableBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$move.play("move")
