extends Node2D


func _input(event):
	if event.is_action_pressed("ui_cancel") and visible:
		get_tree().paused = false
		visible = false
		get_viewport().set_input_as_handled()


func _on_reset_game_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Main.tscn")
