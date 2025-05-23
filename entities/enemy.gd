extends Entity
class_name Enemy

@onready var navigation: NavigationAgent2D = $NavigationAgent2D
@onready var player: Player = get_tree().get_nodes_in_group('player').front()
@onready var cooldown := $AttackCooldown
@onready var sprite: AnimatedSprite2D = $Sprite2D

@export var proj: PackedScene
@export var score: int = 100
@export var avoidance_range: float = 120.0

var can_see_player: bool = false

func _ready() -> void:
	projectile = proj
	navigation.target_desired_distance = avoidance_range
	health = floor(Global.time_secs) + health
	max_health = health

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
	sprite.flip_h = parse_animation(dir) == 'right' 
	sprite.play(parse_animation(dir))

func die() -> void:
	if health <= 0:
		Global.score += score
		Global.display_number(score, position + Vector2.UP * 10, 1.5, "#FFF", "+")
		
		var timer: Timer = get_tree().current_scene.gui.sacrifice.timer
		var current_time = timer.time_left
		timer.stop()
		timer.wait_time = current_time + 1
		timer.start()
		timer.wait_time = Global.BASE_LEVELUP_COOLDOWN
		
		queue_free()

func _on_hurtbox_entered(area: Hitbox) -> void:
	if area.get_parent() is Projectile:
		area.get_parent().expire()
	elif area.get_parent() is DragonBreath:
		area.get_parent().add_enemy(self)
	take_damage(area)
	die()

func _on_hurtbox_exited(area: Hitbox) -> void:
	if area.get_parent() is DragonBreath:
		area.get_parent().remove_enemy(self)

func _on_navigation_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity

func _on_attack_body_entered(_body: Node2D) -> void:
	can_see_player = true

func _on_attack_body_exited(_body: Node2D) -> void:
	can_see_player = false
