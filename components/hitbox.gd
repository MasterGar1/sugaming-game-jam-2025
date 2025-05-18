extends Area2D
class_name Hitbox

@onready var collision := $CollisionShape2D

var damage: int:
	get: return owner.damage if not owner == null else get_parent().damage
