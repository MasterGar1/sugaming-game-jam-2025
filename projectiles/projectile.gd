extends Area2D
class_name Projectile

@export var damage: int
@export var speed: int
@export var direction: Vector2
@export var flight_pattern: Callable
@export var lifespan: int
var start_position: Vector2

## TEST: Only for testing
func _ready() -> void:
	setup(10, 1000, Vector2.RIGHT, 100000)

## Used to initialize a projectile with given stats
func setup(dmg: int, spd: int, dir: Vector2, life: int, pat: Callable = linear_flight) -> void:
	start_position = global_position
	damage = dmg
	speed = spd
	direction = dir.normalized()
	lifespan = life
	flight_pattern = pat

func _physics_process(delta: float) -> void:
	check_despawn()
	var next_pos: Vector2 = flight_pattern.call(direction)
	global_position += lerp(Vector2.ZERO, next_pos, 0.1 * delta * speed)

## Checks if the lifespan of projectile is reached
func check_despawn() -> void:
	if lifespan < global_position.distance_squared_to(start_position):
		queue_free()

## Basic linear flight pattern
static func linear_flight(dir: Vector2) -> Vector2:
	return dir
