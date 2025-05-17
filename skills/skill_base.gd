extends Node2D
class_name Skill

@onready var actor: Entity = get_parent().get_parent()

@export var level: int = 1
@export var skill_name: String
@export var image: Texture2D

func level_up():
	level += 1
