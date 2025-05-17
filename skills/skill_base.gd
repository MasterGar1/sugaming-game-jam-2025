extends Node
class_name Skill

@export var level: int = 1
@export var skill_name: String

func level_up():
	level += 1
