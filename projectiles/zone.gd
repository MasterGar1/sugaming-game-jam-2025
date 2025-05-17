extends Node2D

@onready var hitbox: Hitbox = $Hitbox
@onready var timer: Timer = $Timer

@export var damage: int
@export var lifespan: int

var level: int
var speed_reduction: int

## Sets timer lifespan
func set_timer(lifespan: int) -> void:
	timer.start(lifespan)

## Creates zone at mouse location
func setup(damage: int, lifespan: int, player_position: Vector2, radius: int, level) -> void:
	set_timer(lifespan)
	hitbox.collision.shape.radius = radius * level
	self.damage = damage
	position = player_position
	self.level = level
	speed_reduction = 2 * level

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
