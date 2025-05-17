extends Node2D

@onready var hitbox: Hitbox = $Hitbox
@onready var timer: Timer = $Timer

@export var damage: int
@export var lifespan: int

var level: int
var speed_reduction: int

## Sets timer lifespan
func set_timer(ls: int) -> void:
	timer.start(ls)

## Creates zone at mouse location
func setup(dmg: int, ls: int, player_position: Vector2, radius: int, lvl) -> void:
	set_timer(ls)
	hitbox.collision.shape.radius = radius * lvl
	damage = dmg
	position = player_position
	level = lvl
	speed_reduction = 2 * lvl

## Kills the zone
func expire() -> void:
	queue_free()

func _on_timer_timeout() -> void:
	expire()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.speed /= speed_reduction

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body is Enemy:
		body.speed *= speed_reduction
