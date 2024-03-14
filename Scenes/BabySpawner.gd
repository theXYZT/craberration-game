extends Node2D

var baby_scene: PackedScene = load("res://Scenes/BabyCrab.tscn")
@onready var beach := $".."

var baby_energy: int = 2
var mutant_energy: int = 2
var mutation_rate: float = 0.1

func _on_spawn_timer_timeout():
	var baby: BabyCrab = baby_scene.instantiate()
	baby.position.x = randf_range(360.0, 920.0)
	baby.position.y = 0.0

	baby.baby_eaten.connect(beach.on_baby_eaten)
	baby.baby_escaped.connect(beach.on_baby_escaped)

	if randf() < mutation_rate:
		baby.is_mutant = true
		baby.energy = mutant_energy
	else:
		baby.energy = baby_energy

	add_child(baby)

func get_indigestion():
	baby_energy = 1
	mutant_energy = 1

func get_angry_mutants():
	mutant_energy = -10
