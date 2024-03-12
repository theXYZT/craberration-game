class_name BabyCrab
extends Node2D

var base_speed := 50.0
var speed_multiplier := 1.0

var is_mutant := false

var base_energy := 2
var energy_multiplier := 1

signal baby_eaten(is_mutant, energy)
signal baby_killed(is_mutant)
signal baby_escaped(is_mutant)

func _ready():
	if is_mutant:
		$AnimationPlayer.play("mutant")
		base_speed = 60.0
	else:
		modulate = Color.WHITE
		modulate.v = randf_range(0.8, 1.2)

func _process(delta):
	global_position.y += base_speed * speed_multiplier * delta

func _on_hurtbox_area_entered(hitbox: Hitbox):
	if hitbox.eats:
		consume()
	else:
		die()

func _on_visible_on_screen_notifier_2d_screen_exited():
	escape()

# Baby Crab is eaten!
func consume():
	baby_eaten.emit(is_mutant, base_energy * energy_multiplier)
	queue_free()

# Baby Crab dies :(
func die():
	baby_killed.emit(is_mutant)
	queue_free()

# Baby Crab escapes! :D
func escape():
	baby_escaped.emit(is_mutant)
	queue_free()
