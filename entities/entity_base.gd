extends CharacterBody2D
class_name Entity

@onready var projectile := preload('res://projectiles/projectile.tscn')

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

@export var speed: int = 1:
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

func shoot(dir: Vector2) -> void:
	var nd: Projectile = projectile.instantiate()
	nd.global_position = self.global_position + Vector2.ONE.rotated(randf_range(0, 2 * PI)) * 30
	get_tree().current_scene.add_child(nd)
	nd.setup(10, 10, dir, 1000000)
