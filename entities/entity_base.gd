extends CharacterBody2D
class_name Entity

## TODO: Make setgets and implement damage
@export var health: int
@export var attack: int
@export var speed: int
@export var reload: float

func take_damage(from_what: Hitbox) -> void:
	pass
