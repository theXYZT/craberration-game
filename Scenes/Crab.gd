class_name Crab
extends Node2D

@onready var energy_bar := $EnergyBar
@onready var energy_timer := $EnergyTimer
@onready var death_timer := $DeathTimer
signal no_energy
var tween: Tween

enum {ALIVE, DYING}
var state = ALIVE:
	set(value):
		if state == ALIVE and value == DYING:
			state = value
			death_timer.start()
			energy_bar.modulate = Color(4.5, 0, 0)
			
			if tween:
				tween.kill()
			tween = create_tween()
			tween.tween_property($CrabWhole, "modulate", Color.DARK_GRAY, 0.2).from_current()
			tween.tween_property($CrabWhole, "modulate", Color.DARK_GRAY, 0.2).from_current()
			
			
		if state == DYING and value == ALIVE:
			state = value
			death_timer.stop()
			energy_bar.modulate = Color.WHITE

var max_energy: int = 100
var energy_loss: int = 1
var energy_time: float = 0.2

var energy: int = 0:
	set(value):
		energy = min(value, max_energy)
		energy_bar.value = energy
		if energy > 0:
			state = ALIVE
		else:
			state = DYING

var speed := 150.0
var x_min := 446.0
var x_max := 834.0

func _ready():
	energy = max_energy
	energy_bar.max_value = max_energy
	energy_timer.wait_time = energy_time
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

func _on_death_timer_timeout():
	no_energy.emit()

# ---------
# MUTATIONS
# ---------
func big_left_claw():
	(%LeftClaw as Claw).scale = Vector2(1.5, -1.5)
	x_min = 482.0

func big_right_claw():
	(%RightClaw as Claw).scale = Vector2(1.5, 1.5)
	x_max = 798.0

func become_athletic():
	speed = 180.0  # 150 * 1.20
	energy_timer.wait_time = energy_time / 1.3  # 1.4

func become_lazy():
	speed = 120.0  # 150 * 0.80
	energy_timer.wait_time = energy_time / 0.75  # 0.67
