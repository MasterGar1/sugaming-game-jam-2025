extends Skill
class_name SlowZone

@onready var cooldown := $Cooldown
@onready var zone := preload("res://projectiles/zone.tscn")

@export var base_duration: int = 5
@export var base_radius: int = 200
@export var base_reduction: int = 2

var damage: int = 0
var radius: int:
	get: return base_radius * level
var duration: int:
	get: return base_duration * level
var reduction: int:
	get: return base_reduction * level

func _ready() -> void:
	cooldown.wait_time = cooldown_time

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("zone"):
		try_slow_zone()

func try_slow_zone() -> void:
	if cooldown.is_stopped():
		cooldown.start()
		var slow_zone := zone.instantiate()
		get_tree().current_scene.add_child(slow_zone)
		slow_zone.setup(damage, duration, actor.global_position, radius, reduction)
