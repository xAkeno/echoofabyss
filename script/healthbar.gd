extends ProgressBar

var max_value_amount
var min_value_amount
var parent

func _ready() -> void:
	parent = get_parent()
	max_value_amount = parent.max_health
	min_value_amount = parent.min_health
	
	
	
func _process(delta: float) -> void:
	self.value = parent.health
	if parent.health != max_value_amount:
		self.visible = true
		if parent.health == min_value_amount:
			self.visible = false
	else:
		self.visible = false


func _on_mina_damage_zone_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
