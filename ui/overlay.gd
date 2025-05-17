extends Control

@onready var sacrifice_progress := $SacrificeProgress
@onready var healthbar := $Healthbar

func _process(delta: float) -> void:
	sacrifice_progress.value = get_parent().sacrifice.timer.time_left / Global.BASE_LEVELUP_COOLDOWN * 100
	var player: Player = get_tree().get_nodes_in_group("player")[0]
	healthbar.value = player.health / player.max_health * 100
