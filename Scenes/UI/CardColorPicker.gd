extends Node2D

func _ready():
	$Card.bg_color = $Background.color
	$Card.fg_color = $Foreground.color
	$Card.stylize()

func _on_foreground_color_changed(color):
	$Card.fg_color = color
	$Card.stylize()

func _on_background_color_changed(color):
	$Card.bg_color = color
	$Card.stylize()

func _on_button_pressed():
	print("fg_color = " + str($Foreground.color))
	print("bg_color = " + str($Background.color))
	print()
