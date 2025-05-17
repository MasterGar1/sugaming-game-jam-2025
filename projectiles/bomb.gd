extends Node

@onready var hitbox: Hitbox = $Hitbox

@export var damage: int
@export var lifespan: int

## Used to initialize a bomb with given stats
func setup(dmg: int, start_position: Vector2) -> void:
	self.global_position = start_position
	damage = dmg

func _on_timer_timeout() -> void:
	expire()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.take_damage(damage)

## Kills the bomb
func expire() -> void:
	queue_free()
