extends Node2D
class_name Skill

@onready var actor: Entity = get_parent().get_parent()

@export var level: int = 1
@export var skill_name: String
@export var cooldown_time: float
@export var image: Texture2D
@export var count: int: get = get_count
var current_count: int = count

func level_up() -> void:
	level += 1

func get_count() -> int:
	return 1
