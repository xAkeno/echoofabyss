extends Area2D
@export var damage =20
@export var health = 50


func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is damagable:
			child.hit(damage)
			
#func player_death(health):
	#if (body.name =="ahsoka"):
		#if health <=0:
			#get_tree().reload_current_scene()
		#
		#
