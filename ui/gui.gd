extends CanvasLayer

@onready var sacrifice := $Sacrifice

func pause() -> void:
	get_tree().paused = not get_tree().paused
