extends Node

@onready var score: Label = %score
var points = 0

func add_points():
	points += 1
	print(points)
	score.text =  "Coin - " + str( points)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
