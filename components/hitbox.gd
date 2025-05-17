extends Area2D
class_name Hitbox

@onready var collision := $CollisionShape2D

var damage: int:
	get: return owner.damage
