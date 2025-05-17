extends Skill
class_name MouseBomb

@onready var cooldown := $Timer
@onready var bomb := preload("res://projectiles/bomb.tscn")

var damage: int = 10

func try_mouse_bomb() -> void:
	if cooldown.is_stopped():
		cooldown.start()
	
		var mouse_bomb := bomb.instantiate()
		get_tree().current_scene.add_child(mouse_bomb)
		mouse_bomb.setup(damage, get_global_mouse_position())
		print("bombed")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('bomb'):
		try_mouse_bomb()
