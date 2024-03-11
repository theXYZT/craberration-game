extends CharacterBody2D

@export var speed = 100.0
@export var x_min = 440.0
@export var x_max = 840.0

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	position.x += direction * speed * delta
	if position.x < x_min:
		position.x = x_min
	
	if position.x > x_max:
		position.x = x_max
