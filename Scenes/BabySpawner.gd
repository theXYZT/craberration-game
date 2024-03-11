extends Node2D

var baby_scene: PackedScene = load("res://Scenes/BabyCrab.tscn")

func _on_spawn_timer_timeout():
	var baby: BabyCrab = baby_scene.instantiate()
	baby.position.x = randf_range(360.0, 920.0)
	baby.position.y = -32.0
	
	if randf() < 0.1:
		baby.IS_MUTANT = true
	else:
		baby.baby_eaten.connect(baby_eaten)
	
	add_child(baby)

func baby_eaten(energy):
	pass
