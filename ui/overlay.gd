extends Control

@onready var sacrifice_progress := $Margin/VBox/SacrificeProgress
@onready var healthbar := $Margin2/HBox/Healthbar
@onready var score := $Margin2/HBox/VBox/Score
@onready var time := $Margin2/HBox/VBox/Time
@onready var skills := $Margin/VBox/Skills
@onready var skill_cooldown: Resource = preload("res://ui/skill_cooldown.tscn")

@onready var player: Player = get_tree().get_nodes_in_group("player")[0]

func _ready() -> void:
	await get_tree().current_scene.ready
	for sk in player.skill_holder.get_children():
		var nd: TextureProgressBar = skill_cooldown.instantiate()
		nd.name = sk.skill_name
		nd.texture_under = sk.image
		nd.max_value = sk.cooldown_time
		nd.get_child(0).text = str(sk.count)
		skills.add_child(nd)

func get_time_formatted() -> String:
	var total_sec: int = floor(Global.time_secs)
	var mins: int = floor(total_sec / 60.0)
	var secs: int = total_sec % 60
	return "%02d:%02d" % [mins, secs]

func _process(_delta: float) -> void:
	sacrifice_progress.value = get_parent().sacrifice.timer.time_left / Global.BASE_LEVELUP_COOLDOWN * 100
	healthbar.value = 1.0 * player.health / player.max_health * 100.0
	score.text = "Score: %s" % Global.score
	time.text = "Time: %s" % get_time_formatted()
	
	for i in range(player.skill_holder.get_child_count()):
		skills.get_child(i).value = player.skill_holder.get_child(i).cooldown.time_left if "cooldown" in player.skill_holder.get_child(i) else 0.0
		var cnt: int = player.skill_holder.get_child(i).current_count
		if "cooldown" in player.skill_holder.get_child(i):
			skills.get_child(i).get_child(0).text = str(cnt) if player.skill_holder.get_child(i).cooldown.is_stopped() and cnt > 1 else ''
		else:
			skills.get_child(i).get_child(0).text = str(cnt)

func remove_skill(nm: StringName) -> void:
	for c in skills.get_children():
		if c.name == nm:
			skills.remove_child(c)
			break
