extends Node2D

@onready var hitbox: Hitbox = $Hitbox
@onready var timer: Timer = $Timer

@export var damage: int
@export var lifespan: int

## Sets timer lifespan
func set_timer(lifespan: int) -> void:
	timer.start(lifespan)

## Creates zone at mouse location
func setup(damage: int, lifespan: int, player_position: Vector2, radius: int) -> void:
	set_timer(lifespan)
	hitbox.collision.shape.radius = radius
	self.damage = damage
	position = player_position

## Kills the zone
func expire() -> void:
	queue_free()

func _on_timer_timeout() -> void:
	expire()

func _on_hitbox_body_entered(body: Node2D) -> void:
	print("entered")
	if body is Enemy:
		body.speed /= 2


func _on_hitbox_body_exited(body: Node2D) -> void:
	if body is Enemy:
		body.speed *= 2
