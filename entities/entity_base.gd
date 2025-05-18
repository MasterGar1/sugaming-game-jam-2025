extends CharacterBody2D
class_name Entity

var projectile: Resource

@export var max_health: int
@export var health: int
@export var attack: int
@export var speed: float = 1.0
@export var reload: float = 0.5
@export var projectile_speed: int = 10
@export var projectile_lifespan: int = 1000

func take_damage(from_what: Hitbox) -> void:
	health -= floor(from_what.damage)
	Global.display_number(from_what.damage, position, 1, "#F00")
	die()

func die() -> void:
	pass

func shoot(dir: Vector2) -> void:
	var nd: Projectile = projectile.instantiate()
	nd.global_position = self.global_position + Vector2.ONE.rotated(randf_range(0, 2 * PI)) * 30
	get_tree().current_scene.add_child(nd)
	nd.setup(attack, projectile_speed, dir, projectile_lifespan ** 2)
	nd.look_at(global_position)
