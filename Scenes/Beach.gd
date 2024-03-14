class_name Beach
extends Node2D

@onready var crab := %Crab
@onready var wave_label := %"Wave Label"

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
func on_baby_eaten(energy):
	crab.energy += energy
	
func on_baby_escaped(is_mutant):
	if is_mutant:
		%MutationMeter.mutation += 1

# -----------
# SETUP LEVEL
# -----------
func _ready():
	%GameOver.visible = false
	%Pause.visible = false
	%CardSelection.visible = false
	
	wave_label.modulate = Color.TRANSPARENT
	var tween := create_tween()
	tween.tween_property(wave_label, "modulate", Color.WHITE, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).set_delay(1)
	tween.tween_property(wave_label, "modulate", Color.TRANSPARENT, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).set_delay(4)

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
	%MutationMeter.z_index = 20

func game_over(reason):
	%GameOver.visible = true
	%ReasonLabel.text = reason
	get_tree().paused = true
