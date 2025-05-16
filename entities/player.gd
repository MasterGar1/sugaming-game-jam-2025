extends Entity
class_name Player
# Onready
@onready var projectile := preload('res://projectiles/projectile.tscn')

# Vars
var direction: Vector2

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed * delta
	move_and_slide()
