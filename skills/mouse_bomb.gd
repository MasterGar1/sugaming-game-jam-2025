extends Skill

@onready var cooldown := $Timer
@onready var bomb := preload("res://projectiles/player/bomb.tscn")

@export var base_damage: int = 10
@export var base_lifespan: int = 2
@export var base_radius: int = 100

var damage: int:
	get: return base_damage * level
var lifespan: int:
	get: return base_lifespan * level
var radius: int:
	get: return base_radius + floor(base_radius * (level - 1) / 2.0)

func _ready() -> void:
	cooldown.wait_time = cooldown_time

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('bomb'):
		try_mouse_bomb()

func try_mouse_bomb() -> void:
	if cooldown.is_stopped():
		cooldown.start()
		var mouse_bomb := bomb.instantiate()
		get_tree().current_scene.add_child(mouse_bomb)
		mouse_bomb.setup(damage, get_global_mouse_position(), lifespan, radius)
