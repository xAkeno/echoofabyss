extends Area2D

@export var damage: int = 10

func _ready() -> void:
	Global.player_damage_zone = self
	Global.playerDamageAmount = damage

func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is damagable:
			child.hit(damage)
		
