extends CharacterBody2D
class_name Entity

## TODO: Implement damage
@export var health: int:
	get:
		return health
	set(val):
		health = val

@export var attack: int:
	get:
		return attack
	set(val):
		attack = val

@export var speed: int:
	get:
		return speed
	set(val):
		speed = val

@export var reload: float:
	get:
		return reload
	set(val):
		reload = val

func take_damage(from_what: Hitbox) -> void:
	health -= from_what.damage
