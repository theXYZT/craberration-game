class_name Beach
extends Node2D

# Tracked Stats


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
