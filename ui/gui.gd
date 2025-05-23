extends CanvasLayer

@onready var sacrifice := $Sacrifice
@onready var overlay := $Overlay
@onready var death_menu := $DeathMenu

func pause() -> void:
	overlay.visible = get_tree().paused
	get_tree().paused = not get_tree().paused

func _ready() -> void:
	await get_parent().ready
	get_parent().player.death.connect(game_over)
	
func game_over() -> void:
	Global.in_game = false
	pause()
	death_menu.setup()
	death_menu.show()
