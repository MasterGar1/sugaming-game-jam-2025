extends CanvasLayer

@onready var sacrifice := $Sacrifice
@onready var overlay := $Overlay

func pause() -> void:
	get_tree().paused = not get_tree().paused
