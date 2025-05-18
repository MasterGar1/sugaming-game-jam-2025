extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('pause') and Global.in_game:
		get_parent().pause()
		
		if visible: 
			hide()
		else:
			show()
