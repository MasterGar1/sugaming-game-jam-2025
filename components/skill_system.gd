extends Node

@onready var timer := $Timer
@onready var popup := $CanvasLayer/CenterContainer/SkillSacrifice
@onready var buttons_grid := $CanvasLayer/CenterContainer/SkillSacrifice/VBoxContainer/GridContainer
@onready var player_skills: Node = player.get_node("Skills")

@export var player: Player
@export var skill_button: PackedScene

func _ready() -> void:
	timer.timeout.connect(sacrifice_skill)
	
func sacrifice_skill() -> void:
	var current_skills = player_skills.get_children()
	
	for i in range(current_skills.size()):
		var button = skill_button.instantiate()
		button.text = current_skills[i].skill_name
		buttons_grid.add_child(button)
		button.pressed.connect(end_sacrifice.bind(i))
		
	popup.show()
	get_tree().paused = true

func end_sacrifice(id: int) -> void:
	player_skills.remove_child(player_skills.get_children()[id])
	
	for skill in player_skills.get_children():
		skill.level_up()
		
	for child in buttons_grid.get_children():
		child.queue_free()
		
	popup.hide()
	get_tree().paused = false
