extends Node2D

@onready var hitbox: Hitbox = $Hitbox
@onready var timer: Timer = $Timer
@onready var particles: GPUParticles2D = $GPUParticles2D

@export var damage: int
@export var lifespan: int

var level: int
var speed_reduction: int

## Sets timer lifespan
func set_timer(ls: int) -> void:
	timer.start(ls)

## Creates zone at mouse location
func setup(dmg: int, ls: int, player_position: Vector2, radius: int, reduction: int) -> void:
	set_timer(ls)
	hitbox.collision.shape.radius = radius
	damage = dmg
	position = player_position
	speed_reduction = reduction
	particles.process_material.emission_sphere_radius = radius
	particles.lifetime = ls

## Kills the zone
func expire() -> void:
	queue_free()

func _on_timer_timeout() -> void:
	expire()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy or body is Projectile:
		body.speed /= speed_reduction

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body is Enemy or body is Projectile:
		body.speed *= speed_reduction
