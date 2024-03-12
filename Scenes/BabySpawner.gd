extends Node2D

var baby_scene: PackedScene = load("res://Scenes/BabyCrab.tscn")

func _on_spawn_timer_timeout():
	var baby: BabyCrab = baby_scene.instantiate()
	baby.position.x = randf_range(360.0, 920.0)
	baby.position.y = -32.0
	
	baby.baby_eaten.connect(_on_baby_eaten)
	baby.baby_escaped.connect(_on_baby_escaped)

	if randf() < 0.1:
		baby.is_mutant = true
	
	add_child(baby)

func _on_baby_eaten(is_mutant, energy):
	if is_mutant:
		$"..".SCORE += 100
	else:
		$"..".SCORE += 10

func _on_baby_escaped(is_mutant):
	if is_mutant:
		$"..".game_over()
