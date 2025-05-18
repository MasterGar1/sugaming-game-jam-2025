extends Button

@export var target_scene: PackedScene

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	print(target_scene)
	if target_scene:
		print("aaa")
		Global.score = 0
		Global.time_secs = 0
		get_parent().get_parent().get_parent().get_parent().pause()
		get_tree().change_scene_to_packed(target_scene)
