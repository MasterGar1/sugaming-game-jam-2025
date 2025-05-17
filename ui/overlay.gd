extends Control

@onready var sacrifice_progress := $TextureProgressBar

func _process(delta: float) -> void:
	sacrifice_progress.value = get_parent().sacrifice.timer.time_left / Global.BASE_LEVELUP_COOLDOWN * 100
