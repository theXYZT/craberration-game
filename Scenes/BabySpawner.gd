extends Node2D

var baby_scene: PackedScene = load("res://Scenes/BabyCrab.tscn")
@onready var beach := $".."

func _on_spawn_timer_timeout():
	var baby: BabyCrab = baby_scene.instantiate()
	baby.position.x = randf_range(360.0, 920.0)
	baby.position.y = 0.0
	
	baby.baby_eaten.connect(beach.on_baby_eaten)
	baby.baby_escaped.connect(beach.on_baby_escaped)
	baby.baby_killed.connect(beach.on_baby_killed)

	if randf() < 0.1:
		baby.is_mutant = true
	
	add_child(baby)
