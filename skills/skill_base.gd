extends Node
class_name Skill

@onready var actor: Entity = get_parent().get_parent()

@export var level: int = 1

func level_up():
	level += 1
