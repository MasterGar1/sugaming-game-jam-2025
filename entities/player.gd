extends Entity
class_name Player

# Onready
@onready var collision := $CollisionShape2D
@onready var cooldown := $AttackCooldown
@onready var skill_holder := $Skills

@export var skills: Array[PackedScene]
# Vars
var direction: Vector2
var force_duration: float
var movement_locked: bool = false

signal end_movement_lock()

func _ready() -> void:
	projectile = preload('res://projectiles/player_projectile.tscn')
	for skill in skills:
		$Skills.add_child(skill.instantiate())

func _physics_process(delta: float) -> void:
	if not movement_locked:
		direction = Input.get_vector("left", "right", "up", "down")
		velocity = direction * Global.BASIC_SPEED * speed * delta
		move_and_slide()
	else:
		velocity = direction * Global.BASIC_SPEED * delta
		move_and_slide()
		force_duration -= 1
		
		if force_duration == 0:
			movement_locked = false
			end_movement_lock.emit()

func _on_hurtbox_entered(area: Area2D) -> void:
	take_damage(area)
	die()
	
func apply_force(dir: Vector2, duration: float) -> void:
	direction = dir
	movement_locked = true
	force_duration = duration

## WARNING: DON'T JUST queue_free()
func die() -> void:
	if health < 0:
		print("dead") # For testing purposes

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and cooldown.is_stopped():
		shoot(get_global_mouse_position() - global_position)
		cooldown.start(reload)
		
