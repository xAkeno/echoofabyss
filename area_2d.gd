extends Area2D

var added_health: int
var is_getable: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_getable = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if is_getable and body.name == "ahsoka":
		$AnimatedSprite2D.play("empty")
		var heal_amount = randi_range(20, 40)
		body.heal(heal_amount)
		print("player got heal by a :", heal_amount)
		$sfx_heal.play()
		is_getable = false
	pass
