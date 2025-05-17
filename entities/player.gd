extends Entity
class_name Player

# Vars
var direction: Vector2

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * Global.BASIC_SPEED * speed * delta
	move_and_slide()

func _on_hurtbox_entered(area: Area2D) -> void:
	take_damage(area)

## WARNING: DON'T JUST queue_free()
func die() -> void:
	if health < 0:
		print("dead") # For testing purposes

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		shoot(get_global_mouse_position() - global_position)
