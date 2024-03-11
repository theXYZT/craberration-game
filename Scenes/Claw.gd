extends Node2D

@export var eat_input : String 
enum {IDLE, EAT}

var current_state = null
@onready var anim_player = $AnimationPlayer


func _input(event):
	if event.is_action_pressed(eat_input) and current_state == IDLE:
		anim_player.play("eat")
		current_state = EAT


# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = IDLE


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "eat":
		current_state = IDLE
