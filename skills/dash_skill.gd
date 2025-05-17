extends Skill

@onready var cooldown := $Cooldown

@export var base_duration: float = 20
@export var level: int = 1

var count: int = 1
var duration: float = base_duration

func try_dash() -> void:
	var direction = Input.get_vector("left", "right", "up", "down") * 20
	
	if count <= 0 or direction.length() == 0:
		return
	
	count -= 1
	cooldown.start()
	
	actor.apply_force(direction, base_duration)

func reload():
	count = min(count + 1, level)
	
	if count < level:
		cooldown.start()

func _ready():
	cooldown.timeout.connect(reload)

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SHIFT:
		try_dash()
