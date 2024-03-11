class_name BabyCrab
extends Node2D

var SPEED = 50.0
var IS_MUTANT: bool = false
var ENERGY = 10.0

signal baby_eaten(energy)
signal baby_escaped(is_mutant)


func _ready():
	if IS_MUTANT:
		$AnimationPlayer.play("mutant")
		SPEED = 60.0
	else:
		modulate = Color.WHITE
		modulate.v = randf_range(0.8, 1.2)

func _process(delta):
	position.y += SPEED * delta

func _on_hurtbox_area_entered(area: Area2D):
	consume()

func _on_visible_on_screen_notifier_2d_screen_exited():
	escape()

# Baby Crab is eaten!
func consume():
	baby_eaten.emit(ENERGY)
	queue_free()

# Baby Crab dies :(
func die():
	queue_free()

# Baby Crab escapes! :D
func escape():
	baby_escaped.emit(IS_MUTANT)
	queue_free()
