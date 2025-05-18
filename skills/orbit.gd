extends Skill
class_name Orbit

const DISTANCE: int = 200

@onready var orb := preload("res://projectiles/player/orb.tscn")

@export var base_damage: int = 10
@export var base_orbit_speed: int = 2
@export var base_orb_amount: int = 2

var damage: int:
	get: return base_damage * level
var orbit_speed: int:
	get: return base_orbit_speed + floor(base_orbit_speed * (level - 1) / 2.0)
var orb_amount: int:
	get: return base_orb_amount + level - 1
	
func _ready() -> void:
	for i in range(orb_amount):
		add_orb()
	reposition()
	
func _physics_process(delta: float) -> void:
	rotate(orbit_speed * delta)
	
func add_orb() -> void:
	var nd: Area2D = orb.instantiate()
	add_child(nd)
	nd.body_entered.connect(_on_orb_body_entered)

func reposition() -> void:
	var offset: float = 2 * PI / get_child_count()
	var i: int = 0
	for c in get_children():
		c.position = Vector2.ONE.rotated(offset * i) * DISTANCE
		i += 1
	current_count = orb_amount

func _on_orb_body_entered(body: Node2D) -> void:
	if body is Enemy:
		body.take_damage(get_child(0))

func get_count() -> int:
	return orb_amount

func level_up() -> void:
	super()
	add_orb()
	reposition()
