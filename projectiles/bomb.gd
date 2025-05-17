extends Node2D

@onready var hitbox: Hitbox = $Hitbox
@onready var cooldown := $Cooldown

@export var damage: int
@export var lifespan: int

var level: int

## Used to initialize a bomb with given stats
func setup(dmg: int, start_position: Vector2, level: int) -> void:
	cooldown.start()
	self.global_position = start_position
	self.level = level
	damage = dmg * level
	await tree_entered
	hitbox.collision.shape.radius = level * 2

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.take_damage(damage)

## Kills the bomb
func expire() -> void:
	queue_free()


func _on_cooldown_timeout() -> void:
	expire()
