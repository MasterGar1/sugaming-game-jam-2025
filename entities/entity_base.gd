extends CharacterBody2D
class_name Entity

@onready var projectile := preload('res://projectiles/projectile.tscn')
@export var health: int
@export var attack: int
@export var speed: float = 1.0
@export var reload: float

func take_damage(from_what: Hitbox) -> void:
	health -= from_what.damage

func shoot(dir: Vector2) -> void:
	var nd: Projectile = projectile.instantiate()
	nd.global_position = self.global_position + Vector2.ONE.rotated(randf_range(0, 2 * PI)) * 30
	get_tree().current_scene.add_child(nd)
	nd.setup(10, 10, dir, 1000000)
