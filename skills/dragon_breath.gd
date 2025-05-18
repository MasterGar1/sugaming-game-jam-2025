extends Skill
class_name DragonBreath

@onready var hitbox := $Hitbox
@onready var collider := $Hitbox/CollisionShape2D

@export var max_charge: float = 100 * level
@export var charge: float = max_charge

var cnt: int = 0
var enemies: Array[Enemy]
var damage: float:
	get: return 0.3 * (2 ** level)
	
func add_enemy(enemy: Enemy):
	enemies.append(enemy)
	
func remove_enemy(enemy: Enemy):
	enemies.erase(enemy)
	
func _ready() -> void:
	collider.disabled = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('dragon breath') and charge >= 0:
		collider.disabled = false
		
	if event.is_action_released('dragon breath'):
		collider.disabled = true

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	hitbox.look_at(mouse_pos)
	hitbox.rotate(PI / 2)
	cnt += 1
	
	if not collider.disabled:
		if cnt % 10 == 0:
			for enemy in enemies:
				enemy.take_damage(hitbox)
				enemy.die()
		
		charge -= 0.5
		
		if charge <= 0:
			collider.disabled = false
			enemies.clear()
	else:
		charge += 1
