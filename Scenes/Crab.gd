class_name Crab
extends Node2D

@onready var energy_bar := $EnergyBar
@onready var energy_timer := $EnergyTimer
signal no_energy

var max_energy: int = 100
var energy_loss: int = 5

var energy: int = 0:
	set(value):
		energy = min(value, max_energy)
		energy_bar.value = energy
		if energy < 0:
			no_energy.emit()


var speed := 150.0
var x_min := 440.0
var x_max := 840.0


func _ready():
	energy = max_energy
	energy_bar.max_value = max_energy
	energy_timer.start()


func _process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	global_position.x += direction * speed * delta
	if global_position.x < x_min:
		global_position.x = x_min
	
	if global_position.x > x_max:
		global_position.x = x_max


func _on_energy_timer_timeout():
	energy -= energy_loss


func big_left_claw():
	($LeftClaw as Claw).scale = Vector2(1.5, -1.5)
	x_min = 478.0

func big_right_claw():
	($RightClaw as Claw).scale = Vector2(1.5, 1.5)
	x_max = 802.0
