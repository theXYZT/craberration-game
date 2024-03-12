extends Node2D

@onready var bars = $HBoxContainer.get_children()

var segment: int = 3
var max_mutation: int = segment * 5
signal mutation_ending

var bg1: StyleBoxFlat = preload("res://Scenes/UI/MutationMeterBackground.tres")
var bg2: StyleBoxFlat = preload("res://Scenes/UI/MutationMeterBackgroundFull.tres")
var fg1: StyleBoxFlat = preload("res://Scenes/UI/MutationMeterFill.tres")
var fg2: StyleBoxFlat = preload("res://Scenes/UI/MutationMeterFillFull.tres")


var mutation: int = 0:
	set(value):
		mutation = value
		
		for bar in bars:
			bar.value = mutation
			
			if bar.max_value == mutation:
				(bar as ProgressBar).add_theme_stylebox_override("background", bg2)
				(bar as ProgressBar).add_theme_stylebox_override("fill", fg2)
			
		if mutation == max_mutation:
			mutation_ending.emit()

func _ready():
	var i = 0
	for bar in bars:
		bar.min_value = i
		bar.max_value = i + segment
		bar.value = 0
		bar.step = 1
		i += segment
		
		(bar as ProgressBar).add_theme_stylebox_override("background", bg1)
		(bar as ProgressBar).add_theme_stylebox_override("fill", fg1)
