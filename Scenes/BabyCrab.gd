class_name BabyCrab
extends Node2D

var base_speed := 50.0
var speed_multiplier := 1.0
var was_pushed: bool = false

var is_mutant := false
var energy: int = 2

signal baby_eaten(energy)
signal baby_escaped(is_mutant)

func _ready():
	was_pushed = false
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
		push_back()

func _on_visible_on_screen_notifier_2d_screen_exited():
	escape()

# Baby Crab is eaten!
func consume():
	baby_eaten.emit(energy)
	queue_free()

# Baby Crab escapes! :D
func escape():
	baby_escaped.emit(is_mutant)
	queue_free()

func push_back():
	if not was_pushed:
		speed_multiplier /= 2.0
	var tween = create_tween()
	tween.tween_property(self, "position:y", -50, 0.5).as_relative().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
