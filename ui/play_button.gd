extends Button

func _ready():
	pressed.connect(_on_pressed)
	get_tree().paused = false

func _on_pressed():
	get_tree().change_scene_to_file("res://world/world.tscn")
	Global.in_game = true
