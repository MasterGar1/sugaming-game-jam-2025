extends Entity
class_name Player

# Onready
@onready var collision := $CollisionShape2D
@onready var cooldown := $AttackCooldown
@onready var skill_holder := $Skills
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var camera := $Camera2D

@export var skills: Array[PackedScene]
# Vars
var direction: Vector2
var force_duration: float
var movement_locked: bool = false

signal end_movement_lock()
signal death()

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
	if direction == Vector2.ZERO:
		sprite.play('idle')
	else:
		sprite.flip_h = parse_animation(direction) == 'left'
		sprite.play(parse_animation(direction))

func _on_hurtbox_entered(area: Area2D) -> void:
	if movement_locked:
		return
	camera.apply_shake()
	take_damage(area)
	die()
	
func apply_force(dir: Vector2, duration: float) -> void:
	direction = dir
	movement_locked = true
	force_duration = duration

## WARNING: DON'T JUST queue_free()
func die() -> void:
	if health <= 0 and Global.in_game:
		death.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and cooldown.is_stopped():
		shoot(get_global_mouse_position() - global_position)
		cooldown.start(reload)
