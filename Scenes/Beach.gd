class_name Beach
extends Node2D

@onready var crab := %Crab

# -------------
# TRACKED STATS
# -------------
var wave: int = 0
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

func on_baby_eaten(_is_mutant, energy):
	crab.energy += energy
	
func on_baby_escaped(is_mutant):
	if is_mutant:
		%MutationMeter.mutation += 1
	
func on_baby_killed(_is_mutant):
	pass
	
# -----------
# SETUP LEVEL
# -----------
func _ready():
	$"Game Over".visible = false
	$PausedLabel.visible = false	

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
func _on_crab_no_energy():
	game_over("You ran out of energy.")

func _on_mutation_meter_mutation_ending():
	game_over("You became a mutant crab. Eww.")

func game_over(reason):
	$"Game Over".visible = true
	$"Game Over/ReasonLabel".text = reason
	get_tree().paused = true
