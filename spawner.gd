extends Node2D

@onready var enemy_gab = preload("res://scenes/enemy/gab.tscn")
@onready var enemy_boto = preload("res://scenes/enemy/boto.tscn")
@onready var enemy_mina = preload("res://scenes/enemy/mina.tscn")
@onready var countdown_timer = $CountdownTimer
@onready var label = $Label
var remaining_time := 0
var spawned_enemies: Array = []
var phase := 0
var started := false
var cleared_waves := 0
var wavefinish := false
func _ready() -> void:
	randomize()
	print("Spawner ready")

	# Connect Timer's timeout signal to _on_Timer_timeout
	$Timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	
func _process(delta):
	if spawned_enemies.size() > 0:
		# Remove enemies that no longer exist
		spawned_enemies = spawned_enemies.filter(func(e): return is_instance_valid(e) and e.get_parent() != null)
		
		# Check if all are dead
		if spawned_enemies.is_empty():
			print("=============================All enemies defeated.=========================")
			cleared_waves += 1
			spawned_enemies.clear()  # clear just in case
			if cleared_waves >= 3 and not wavefinish:
				wavefinish = true
				GlobalScript.waveFinish = true
				print("All waves cleared. wavefinish = true")

func _on_area_2d_body_entered(body: Node) -> void:
	if body.name == "ahsoka" and not started:
		started = true
		label.text = "You fell from the trap you must survive!"
		print("Spawning started")

		# Spawn initial gab enemies deferred (to avoid physics flush error)
		call_deferred("spawn_multiple", enemy_gab, 3)

		# Start timer for next phase in 20 seconds
		$Timer.wait_time = 20
		$Timer.start()

func _on_Timer_timeout() -> void:
	print("Timer timeout, current phase: ", phase)
	match phase:
		0:
			print("Phase 0: Spawning boto")
			label.text = "Phase 1: Spawning skeletons"
			call_deferred("spawn_multiple", enemy_boto, 3)
			phase = 1
			
			$Timer.wait_time = 20
			$Timer.start()
		1:
			print("Phase 2: Elite minotaur")
			label.text = "Phase 2: Elite minotaur!"
			call_deferred("spawn_multiple", enemy_mina, 3)
			phase = 2
			print("All phases complete")
			$Timer.wait_time = 30
		2:
			print("Phase 3: Spawning nigga")
			label.text = "Final phase: survive the onslaught!"
			call_deferred("spawn_multiple", enemy_mina, 2)
			call_deferred("spawn_multiple", enemy_gab, 3)
			call_deferred("spawn_multiple", enemy_boto, 3)
			print("All phases complete")
			$Timer.stop()
		_:
			label.text = ""
			print("the gate is open")
			$Timer.stop()

func spawn_multiple(enemy_scene: PackedScene, count: int) -> void:
	for i in range(count):
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.position = position + Vector2(randi_range(-50, 50), -100)
		get_parent().add_child(enemy_instance)
		spawned_enemies.append(enemy_instance)
