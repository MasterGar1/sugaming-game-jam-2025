extends Entity
class_name Enemy

@onready var navigation: NavigationAgent2D = $NavigationAgent2D
@onready var player: Player = get_tree().get_nodes_in_group('player').front()
@onready var cooldown := $AttackCooldown

@export var proj: PackedScene = preload('res://projectiles/enemy_projectile.tscn')
@export var score: int = 100
@export var avoidance_range: float = 120.0

var can_see_player: bool = false

func _ready() -> void:
	projectile = proj
	navigation.target_desired_distance = avoidance_range

func _process(_delta: float) -> void:
	if can_see_player and cooldown.is_stopped():
		call_deferred('shoot', to_local(player.global_position))
		cooldown.start(reload)

func _physics_process(delta: float) -> void:
	follow_player(delta)

func follow_player(delta: float) -> void:
	navigation.target_position = player.global_position
	var dir: Vector2 = to_local(navigation.get_next_path_position())
	navigation.set_velocity(dir.normalized() * Global.BASIC_SPEED * delta)
	velocity *= speed
	move_and_slide()

func die() -> void:
	if health <= 0:
		Global.score += score
		queue_free()

func _on_hurtbox_entered(area: Hitbox) -> void:
	take_damage(area)
	if area.get_parent() is Projectile:
		area.get_parent().expire()
	die()

func _on_navigation_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity

func _on_attack_body_entered(_body: Node2D) -> void:
	can_see_player = true

func _on_attack_body_exited(_body: Node2D) -> void:
	can_see_player = false
