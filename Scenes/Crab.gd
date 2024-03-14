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
			
			if tween:
				tween.kill()
			tween = create_tween().set_loops(2)
			tween.tween_property(self, "modulate", Color(0.4, 0.4, 0.4), 0.15).set_trans(Tween.TRANS_SINE)
			tween.tween_property(self, "modulate", Color.WHITE, 0.15).set_trans(Tween.TRANS_SINE)

		if state == DYING and value == ALIVE:
			state = value
			death_timer.stop()
			if tween:
				tween.kill()
			modulate = Color.WHITE

var max_energy: int = 100
var energy_loss: int = 1
var energy_time: float = 0.2

var energy: int = 0:
	set(value):
		energy = max(0, min(value, max_energy))
		energy_bar.value = energy
		if energy > 0:
			state = ALIVE
		else:
			state = DYING

		if energy < 10:
			energy_bar.modulate = Color(5, 0, 0)
		elif energy < 50:
			energy_bar.modulate = Color(4.5, 1, 1)
		else:
			energy_bar.modulate = Color.WHITE

var speed := 150.0
var x_min := 446.0
var x_max := 834.0

enum Moves {DASH, SAND}
enum MoveState {IDLE, MOVING}
var special_move = null
var special_move_state = null
var sand_box_pos_y: float
var dash_pos_x: float
var move_cost: int = 25
var move_energy_min: int = 50

func _ready():
	energy = max_energy
	energy_bar.max_value = max_energy
	energy_timer.wait_time = energy_time
	energy_timer.start()
	special_move_state = MoveState.IDLE

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

func get_dash_move():
	special_move = Moves.DASH

func get_sand_move():
	special_move = Moves.SAND

# ------------
# SPECIAL MOVE
# ------------
func _input(event):
	if event.is_action_pressed("space") and special_move_state == MoveState.IDLE and energy >= move_energy_min:
		if special_move == Moves.DASH:
			dash_move()
		elif special_move == Moves.SAND:
			sand_move()

func dash_move():
	if Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right"):
		return
	
	if Input.is_action_pressed("move_left"):
		dash_pos_x = x_min
	elif Input.is_action_pressed("move_right"):
		dash_pos_x = x_max
	else:
		return
	
	special_move_state = MoveState.MOVING
	energy -= move_cost
	
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "global_position:x", dash_pos_x, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.chain().tween_callback(turn_off_dash)

func turn_off_dash():
	special_move_state = MoveState.IDLE

func sand_move():
	special_move_state = MoveState.MOVING
	energy -= move_cost
	
	sand_box_pos_y = $SandHitBox.global_position.y
	$SandHitBox/Collider.disabled = false
	var tween = $SandHitBox.create_tween()
	tween.tween_property($SandHitBox, "global_position:y", -80, 0.5).as_relative().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(turn_off_sand_box)

func turn_off_sand_box():
	$SandHitBox/Collider.disabled = true
	$SandHitBox.global_position.y = sand_box_pos_y
	special_move_state = MoveState.IDLE
