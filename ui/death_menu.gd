extends Control

@onready var score := $MarginContainer/VBoxContainer/Score
@onready var time := $MarginContainer/VBoxContainer/Time

func setup() -> void:
	if Global.high_score < Global.score:
		score.text = "New high score: %s!" % Global.score
	else:
		score.text = "Score: %s" % Global.score
		
	time.text = "Time: %s" % Global.get_time_formatted()
