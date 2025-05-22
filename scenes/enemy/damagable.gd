extends Node
class_name damagable
@export var health: float = 50
@export var ahsoka: CharacterBody2D
signal on_hit(node:Node , damage_taken: int)
	
func hit(damage: int):
	health -= damage
	emit_signal("on_hit", get_parent(), damage)
	
	if(health <= 0):
		get_parent().queue_free()	
	
	
	
