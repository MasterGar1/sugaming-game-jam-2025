extends Control

@onready var timer: Timer = $Timer
@onready var skill_holder := $Margin/VBox/HBox
@onready var skill_button := preload("res://ui/skill_button.tscn")

func _ready() -> void:
	timer.start(Global.BASE_LEVELUP_COOLDOWN)

func skill_selected(sk) -> void:
	var skills = get_tree().get_nodes_in_group("player")[0].skill_holder
	skills.remove_child(sk)
	
	for skill in skills.get_children():
		skill.level_up()
	
	hide()
	get_parent().pause()
	remove_skills()
	
	if skills.get_child_count() > 0:
		timer.start(Global.BASE_LEVELUP_COOLDOWN)
	else:
		get_parent().overlay.remove_child(get_parent().overlay.get_child(0))

func add_skills() -> void:
	for sk in get_tree().get_nodes_in_group("player")[0].skill_holder.get_children():
		var sb: Button = skill_button.instantiate()
		sb.button_up.connect(skill_selected.bind(sk))
		sb.icon = sk.image
		sb.tooltip_text = sk.skill_name
		skill_holder.add_child(sb)

func remove_skills() -> void:
	while skill_holder.get_child_count() > 0:
		skill_holder.remove_child(skill_holder.get_child(0))

func _on_timer_timeout() -> void:
	if get_tree().get_nodes_in_group("player")[0].skill_holder.get_child_count() == 0: 
		return
	get_parent().pause()
	add_skills()
	show()
