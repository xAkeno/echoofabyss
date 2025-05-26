extends Node
@export var bonfire_id: String
@onready var score: Label = %score
@onready var key: Label = %key
var points = 0

func add_points():
	points += 1
	print(points)
	score.text =  "🪙 - " + str(points)

func enemy_point(point_enemy:int):
	points += point_enemy
	print("the enemy you kill gets you :", point_enemy)
	score.text =  "🪙 - " + str( points)
	pass
func update_key():
	key.text = "🗝 - 1/1"
	print("key geten")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var current = get_tree().current_scene.scene_file_path
	var saved_data = SaveSystem.load_game()
	if saved_data:
		$"../ahsoka".global_position = saved_data["position"]
		var gm = %gamemanager
		gm.points = saved_data.get("coins", 0)
		gm.score.text = "🪙 - " + str(gm.points)
		print("Loaded player at saved bonfire position with coins: ", gm.points)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
