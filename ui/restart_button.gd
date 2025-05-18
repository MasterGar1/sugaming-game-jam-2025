extends Button

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	Global.score = 0
	Global.time_secs = 0
	get_tree().change_scene_to_file("res://world/main_menu.tscn")
