extends Node2D

func _on_reset_game_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Main.tscn")
