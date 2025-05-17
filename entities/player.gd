extends Entity
class_name Player
# Onready
@onready var projectile := preload('res://projectiles/projectile.tscn')

# Vars
var direction: Vector2

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * Global.BASIC_SPEED * speed * delta
	move_and_slide()

## TODO: Make it take damage
func _on_hurtbox_entered(area: Area2D) -> void:
	pass # Replace with function body.
	
## WARNING: DON'T JUST queue_free()
func die() -> void:
	pass
