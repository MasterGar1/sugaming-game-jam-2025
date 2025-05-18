extends Skill
class_name DragonBreath

@onready var hitbox := $Hitbox
@onready var collider := $Hitbox/CollisionShape2D
@onready var particles: GPUParticles2D = $Hitbox/GPUParticles2D

@export var max_charge: float:
	get: return 100 * (1 + level) / 2.0
@export var charge: float = max_charge

var cnt: int = 0
var enemies: Array[Enemy]
var damage: float:
	get: return 2 ** level
	
func add_enemy(enemy: Enemy) -> void:
	enemies.append(enemy)
	enemy.speed -= 0.2 * (1 + level)
	
func remove_enemy(enemy: Enemy) -> void:
	enemies.erase(enemy)
	enemy.speed += 0.2 * (1 + level)
	
func level_up() -> void:
	super()
	collider.shape.height *= 1.2
	change_state(true)
	charge = max_charge
	
func change_state(state: bool) -> void:
	collider.disabled = state
	particles.emitting = not state
	
func _ready() -> void:
	change_state(true)
	current_count = 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('dragon breath') and charge >= 0:
		change_state(charge < 0)

func _process(_delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	hitbox.look_at(mouse_pos)
	hitbox.rotate(PI / 2)
	cnt += 1
	
	if not collider.disabled:
		if cnt % 8 == 0:
			for enemy in enemies:
				enemy.take_damage(hitbox)
				enemy.die()
		
		charge -= 0.5
		
		if charge <= 0:
			change_state(true)
			enemies.clear()
	else:
		charge = min(charge + 0.3, max_charge)
		
	current_count = int(charge)
