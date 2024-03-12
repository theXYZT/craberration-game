class_name Hitbox
extends Area2D

@export var eats := true

func _init() -> void:
	collision_layer = 1
	collision_mask = 2
