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
	take_damage(area)
	print(health)

## WARNING: DON'T JUST queue_free()
func die() -> void:
	if health < 0:
		print("dead") # For testing purposes

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		shoot()

# Shoots projectile from the player's position towards where they are facing
func shoot() -> void:
	var nd: Projectile = projectile.instantiate()
	nd.global_position = self.global_position
	get_tree().current_scene.add_child(nd)
	nd.setup(10, 100000, get_global_mouse_position() - global_position, 10) # Default values
