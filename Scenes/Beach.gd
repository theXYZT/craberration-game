class_name Beach
extends Node2D

@onready var crab := %Crab

# -------------
# TRACKED STATS
# -------------
var wave: int = 0
var energy: int = 0
var mutation: int = 0
var score: int = 0

var stats: Dictionary = {
	"normal_baby_eaten": {
		"name": "Normal Baby Crabs Eaten",
		"count": 0,
		"multiplier": 1,
	},
	"normal_baby_escaped": {
		"name": "Normal Baby Crabs Escaped",
		"count": 0,
		"multiplier": 0,
	},
	"mutant_baby_eaten": {
		"name": "Mutant Baby Crabs Eaten",
		"count": 0,
		"multiplier": 5,
	},
	"mutant_baby_escaped": {
		"name": "Mutant Baby Crabs Escaped",
		"count": 0,
		"multiplier": 0,
	},
}

# -----------------
# BABY CRAB SIGNALS
# -----------------
func on_baby_eaten(is_mutant, energy):
	crab.energy += energy
	
func on_baby_escaped(is_mutant):
	pass
	
func on_baby_killed(is_mutant):
	pass
	




var SCORE := 0:
	set(value):
		SCORE = value
		$Score.text = "Score: " + str(SCORE)


# ----------
# PAUSE GAME
# ----------
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$"PausedLabel".visible = true
		get_tree().paused = true

# ---------
# GAME OVER
# ---------
func game_over():
	$"Game Over".visible = true
	get_tree().paused = true
