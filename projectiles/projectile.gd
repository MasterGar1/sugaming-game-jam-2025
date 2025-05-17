extends CharacterBody2D
class_name Projectile

@onready var hitbox: Hitbox = $Hitbox

@export var damage: int
@export var speed: int
@export var direction: Vector2
@export var flight_pattern: Callable ## Has to return the next point of flight
@export var lifespan: int
var start_position: Vector2

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
	velocity = next_pos * speed * delta
	if move_and_slide(): expire()

## Kills the projectile
func expire() -> void:
	queue_free()

## Checks if the lifespan of projectile is reached
func check_despawn() -> void:
	if lifespan < global_position.distance_squared_to(start_position):
		pass

## Basic linear flight pattern
static func linear_flight(dir: Vector2) -> Vector2:
	return dir
