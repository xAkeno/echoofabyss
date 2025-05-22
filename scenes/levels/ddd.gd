extends Area2D

@export var dialog_key = ""
var area_active = false

func _ready():
	dialog_key = "door"

func _input(event):
	if area_active and event.is_action("skip"):
		print("i got used")
		SignalBus.emit_signal("display_dialog",dialog_key)

func _on_area_entered(area: Area2D) -> void:
	print("Hello")
	area_active = true
	

func _on_area_exited(area: Area2D) -> void:
	print("Hello")
	area_active = false
	
