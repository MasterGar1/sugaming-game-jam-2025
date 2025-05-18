extends Control

@onready var score := $MarginContainer/VBoxContainer/Score
@onready var time := $MarginContainer/VBoxContainer/Time

func setup() -> void:
	score.text = "Score: %s" % Global.score
	time.text = "Time: %s" % Global.get_time_formatted()
