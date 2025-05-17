extends Skill

const DASH_SPEED: float = 20.0

@onready var cooldown := $Cooldown
@onready var collider := $Hitbox/CollisionShape2D

@export var base_duration: float = 20.0

var duration: float = base_duration
var damage: int = 5

func _ready() -> void:
	actor.end_movement_lock.connect(end_dash)
	cooldown.wait_time = cooldown_time
	collider.disabled = true
	current_count = count

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dash"):
		try_dash()

func try_dash() -> void:
	var direction = Input.get_vector("left", "right", "up", "down") * DASH_SPEED
	
	if current_count <= 0 or direction.length() == 0 or not collider.disabled:
		return
	
	current_count -= 1
	if current_count == 0: cooldown.start()
	actor.collision.disabled = true
	collider.disabled = false
	
	actor.apply_force(direction, base_duration)

func get_count() -> int:
	return level

func reload() -> void:
	current_count = count
		
func end_dash() -> void:
	actor.collision.disabled = false
	collider.disabled = true
	
func level_up() -> void:
	super()
	reload()
	cooldown.stop()
