extends Entity
class_name Enemy

@onready var navigation: NavigationAgent2D = $NavigationAgent2D
@onready var player: Player = get_tree().get_nodes_in_group('player').front()

func _physics_process(delta: float) -> void:
	follow_player(delta)

func follow_player(delta: float) -> void:
	var dir: Vector2 = to_local(navigation.get_next_path_position())
	velocity = dir.normalized() * speed * delta
	move_and_slide()
	make_path()

func make_path() -> void:
	navigation.target_position = player.global_position
	
