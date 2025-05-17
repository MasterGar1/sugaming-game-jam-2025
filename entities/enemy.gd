extends Entity
class_name Enemy

@onready var navigation: NavigationAgent2D = $NavigationAgent2D
@onready var player: Player = get_tree().get_nodes_in_group('player').front()
@onready var cooldown := $AttackCooldown

@export var proj: PackedScene = preload('res://projectiles/enemy_projectile.tscn')

var can_see_player: bool = false

func _ready() -> void:
	projectile = proj

func _process(_delta: float) -> void:
	if can_see_player and cooldown.is_stopped():
		call_deferred('shoot', to_local(player.global_position))
		cooldown.start(reload)
		get_global_mouse_position()

func _physics_process(delta: float) -> void:
	follow_player(delta)

func follow_player(delta: float) -> void:
	make_path()
	var dir: Vector2 = to_local(navigation.get_next_path_position()).normalized()
	navigation.set_velocity(dir * Global.BASIC_SPEED * speed * delta)
	move_and_slide()

func make_path() -> void:
	navigation.target_position = player.global_position

## TODO: Make it take damage
func _on_hurtbox_entered(area: Hitbox) -> void:
	take_damage(area)
	area.get_parent().expire()
	die()

func die() -> void:
	if health <= 0:
		## TODO: Other death stuff
		queue_free()

func _on_navigation_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity

func _on_attack_body_entered(_body: Node2D) -> void:
	can_see_player = true

func _on_attack_body_exited(body: Node2D) -> void:
	can_see_player = false
