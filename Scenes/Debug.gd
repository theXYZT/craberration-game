extends Control



func _on_fast_pressed():
	Engine.time_scale = 2.0

func _on_normal_pressed():
	Engine.time_scale = 1.0

func _on_slow_pressed():
	Engine.time_scale = 0.1

func _on_button_pressed():
	%MutationMeter.mutation += 1
