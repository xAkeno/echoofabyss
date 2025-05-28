extends Node
@export var bonfire_id: String
@onready var score: Label = %score
@onready var key: Label = %key
var high_score: int = 0
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
	
func _ready() -> void:
	var current = get_tree().current_scene.scene_file_path
	var saved_data = SaveSystem.load_game()
	if saved_data:
		$"../ahsoka".global_position = saved_data["position"]
		var gm = %gamemanager
		gm.points = saved_data.get("coins", 0)
		gm.score.text = "🪙 - " + str(gm.points)
		print("Loaded player at saved bonfire position with coins: ", gm.points)

func save_high_score(score: int) -> void:
	var file = FileAccess.open("user://highscore.save", FileAccess.WRITE)
	if file:
		file.store_string(str(score))
		file.close()

func load_high_score() -> int:
	if FileAccess.file_exists("user://highscore.save"):
		var file = FileAccess.open("user://highscore.save", FileAccess.READ)
		if file:
			var data = file.get_as_text().strip_edges()
			file.close()
			return int(data) if data.is_valid_integer() else 0
	return 0

	
	
func get_digits(text: String) -> String:
	var result := ""
	for c in text:
		if c in "0123456789":
			result += c
	return result
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
