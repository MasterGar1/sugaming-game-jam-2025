extends Node2D

@onready var hitbox: Hitbox = $Hitbox
@onready var cooldown := $Cooldown
@onready var shape := $Hitbox/CollisionShape2D
@onready var particles: GPUParticles2D = $GPUParticles2D
@onready var ground: GPUParticles2D = $Ground

@export var damage: int
@export var lifespan: int

var damage_burn: int
var damage_base: int
var imposters: Array[Node2D]

func _ready() -> void:
	particles.emitting = true

## Used to initialize a bomb with given stats
func setup(dmg: int, start_position: Vector2, ls: int, rd: int) -> void:
	global_position = start_position
	damage = dmg
	lifespan = ls
	shape.shape.radius = rd
	damage_burn = floor(damage / 2.0)
	damage_base = damage
	cooldown.start(lifespan)
	ground.emitting = true
	ground.lifetime = lifespan
	ground.process_material.emission_sphere_radius = rd

## Kills the bomb
func expire() -> void:
	queue_free()

func _on_cooldown_timeout() -> void:
	expire()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		damage = damage_base
		body.take_damage(hitbox)
		imposters.append(body)

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body is Enemy:
		imposters.remove_at(imposters.find(body))

func _on_tick_timeout() -> void:
	damage = damage_burn
	for imp in imposters:
		imp.take_damage(hitbox)
