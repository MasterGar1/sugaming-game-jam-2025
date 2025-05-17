extends Skill
class_name SlowZone

@onready var cooldown := $Cooldown
@onready var zone := preload("res://projectiles/zone.tscn")

@export var base_duration: float = 3
@export var level: int = 1

var damage: int = 0
var radius = 200
var count: int = 1
var duration: float = base_duration

func try_slow_zone() -> void:
	cooldown.start()
	
	var slow_zone := zone.instantiate()
	get_tree().current_scene.add_child(slow_zone)
	slow_zone.setup(damage, duration, actor.global_position, radius)

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_C:
		try_slow_zone()

func _on_cooldown_timeout() -> void:
	count = min(count + 1, level)
	
	if count < level:
		cooldown.start()
