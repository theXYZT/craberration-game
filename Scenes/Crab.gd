class_name Crab
extends Node2D

@export var speed := 150.0
@export var x_min := 440.0
@export var x_max := 840.0

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	global_position.x += direction * speed * delta
	if global_position.x < x_min:
		global_position.x = x_min
	
	if global_position.x > x_max:
		global_position.x = x_max
