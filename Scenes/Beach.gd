class_name Beach
extends Node2D

@onready var crab := %Crab

# -------------
# TRACKED STATS
# -------------
var wave: int = 0



# -------------
# MUTATION CODE
# -------------
func _on_mutation_meter_mutate():
	%CardSelection.visible = true
	get_tree().paused = true
	%CardSelection.mutate()

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
	%GameOver.visible = false
	%Pause.visible = false
	%CardSelection.visible = false

# ----------
# PAUSE GAME
# ----------
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		%Pause.visible = true
		get_tree().paused = true

# ---------
# GAME OVER
# ---------
func _on_crab_no_energy():
	game_over("You ran out of energy.")

func _on_mutation_meter_mutation_ending():
	game_over("You became a mutant crab. Eww.")

func game_over(reason):
	%GameOver.visible = true
	%ReasonLabel.text = reason
	get_tree().paused = true
