extends Control

@onready var sacrifice_progress := $SacrificeProgress
@onready var healthbar := $Healthbar
@onready var score := $Score
@onready var time := $Time

func get_time_formatted() -> String:
	var total_sec = int(Global.time_secs)
	var min = total_sec / 60
	var sec = total_sec % 60
	return "%02d:%02d" % [min, sec]

func _process(delta: float) -> void:
	sacrifice_progress.value = get_parent().sacrifice.timer.time_left / Global.BASE_LEVELUP_COOLDOWN * 100
	var player: Player = get_tree().get_nodes_in_group("player")[0]
	healthbar.value = player.health / player.max_health * 100
	score.text = "Score: %s" % Global.score
	time.text = "Time: %s" % get_time_formatted()
