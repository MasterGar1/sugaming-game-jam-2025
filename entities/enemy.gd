extends Entity
class_name Enemy

@onready var navigation: NavigationAgent2D = $NavigationAgent2D
@onready var player: Player = get_tree().get_nodes_in_group('player').front()

func _physics_process(delta: float) -> void:
	follow_player(delta)

func follow_player(delta: float) -> void:
	make_path()
	var dir: Vector2 = to_local(navigation.get_next_path_position())
	velocity = dir.normalized() * Global.BASIC_SPEED * speed * delta
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
