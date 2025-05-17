extends Node

@onready var timer := $Timer
@onready var player_skills: Node = player.get_node("Skills")

@export var player: Player
@export var skills: Array[PackedScene]

func _ready() -> void:
	timer.timeout.connect(sacrifice_skill)
	
	for skill in skills:
		player_skills.add_child(skill.instantiate())
	
func sacrifice_skill() -> void:
	player_skills.remove_child(player_skills.get_children().pick_random())
	
	for skill in player_skills.get_children():
		skill.level_up()
