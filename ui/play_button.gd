extends Button

@export var target_scene: PackedScene

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	if target_scene:
		get_tree().change_scene_to_packed(target_scene)
		Global.time_secs = 0
