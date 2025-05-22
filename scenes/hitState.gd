extends State
class_name hit_state

@export var Damagable : damagable
@export var skeletonStateMachine: ashokaStateMachine
@export var dead_state : State


func _ready():
	Damagable.connect("on_hit", on_damagable_hit)
		
		
func on_damagable_hit(node: Node, damage_amount : int):
	if(Damagable.health >0 ):
		emit_signal("interupt_state", self)
			
	else:
		emit_signal("interupt_state", dead_state)
