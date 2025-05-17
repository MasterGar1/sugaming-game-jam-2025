extends Skill

const DASH_SPEED: float = 20

@onready var cooldown := $Cooldown
@onready var collider := $Hitbox/CollisionShape2D
@onready var count: int = level

@export var base_duration: float = 20

var duration: float = base_duration
var damage: int = 5

func try_dash() -> void:
	var direction = Input.get_vector("left", "right", "up", "down") * DASH_SPEED
	
	if count <= 0 or direction.length() == 0 or not collider.disabled:
		return
	
	count -= 1
	cooldown.start()
	actor.collision.disabled = true
	collider.disabled = false
	
	actor.apply_force(direction, base_duration)

func reload():
	count = level
		
func end_dash():
	actor.collision.disabled = false
	collider.disabled = true
	
func level_up():
	super()
	reload()
	cooldown.stop()

func _ready():
	print(count)
	cooldown.timeout.connect(reload)
	actor.end_movement_lock.connect(end_dash)
	collider.disabled = true

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SHIFT:
		try_dash()
