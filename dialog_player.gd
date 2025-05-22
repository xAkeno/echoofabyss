extends CanvasLayer

@export_file("*json") var scene_text_file: String

var scene_text: Dictionary = {}
var selected_text: Array = []
var in_progress: bool = false


@onready var background = $Background
@onready var text_label = $TextLabel
@onready var skip = $TouchScreenButton
func _ready():
	background.visible = false
	skip.visible = false
	scene_text = load_scene_text()
	SignalBus.connect("display_dialog", Callable(self, "on_display_dialog"))

func load_scene_text():
	if FileAccess.file_exists(scene_text_file):
		var file = FileAccess.open(scene_text_file, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		return test_json_conv.get_data()
		
func _unhandled_input(event):
	if in_progress and event.is_action_pressed("skip"):
		print("Going to next line")
		next_line()

func show_text():
	text_label.text = selected_text.pop_front()

func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()

func finish():
	text_label.text = ""
	background.visible = false
	skip.visible = false
	in_progress = false
	get_tree().paused = false
	
func on_display_dialog(text_key):
	if in_progress:
		next_line()
	else:
		if typeof(text_key) != TYPE_STRING or text_key == "":
			push_error("Invalid or missing text key.")
			return	

		if not scene_text.has(text_key):
			push_error("Text key not found in scene_text: '%s'" % text_key)
			return

		var value = scene_text[text_key]
		if typeof(value) != TYPE_ARRAY:
			push_error("Text key '%s' does not contain an array." % text_key)
			return

		get_tree().paused = true
		background.visible = true
		skip.visible = true
		in_progress = true
		selected_text = value.duplicate()
		show_text()


func _on_touch_screen_button_pressed() -> void:
	next_line()
	pass # Replace with function body.
