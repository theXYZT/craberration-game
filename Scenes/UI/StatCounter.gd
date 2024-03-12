extends Control

@export var stat_text: String = "Normal Baby Crabs Eaten:"
@export var count: int = 0
@export var multiplier: int = 1

func _ready():
	$StatText.text = stat_text
	$Count.text = str(count)
	$Multiplier.text = "[right]x " + str(multiplier) + "[/right]"
