extends Area2D
class_name Hitbox

@onready var collision := $CollisionShape2D

var damage: float:
	get: return owner.damage if not owner == null else get_parent().damage
