extends Node

const SCORE_FILE: String = "res://score.tres"
const BASIC_SPEED: int = 10000
const BASE_LEVELUP_COOLDOWN: int = 30

var score: int = 0
var time_secs: float = 0

func save_score() -> void:
	var file = FileAccess.open(SCORE_FILE, FileAccess.WRITE_READ)
	file.store_64(score)
	
func load_scores() -> Vector2:
	var file = FileAccess.open(SCORE_FILE, FileAccess.READ)
	var scores : Vector2
	
	if FileAccess.file_exists(SCORE_FILE):
		scores = file.readLines()
	
	return scores

func display_number(value: float, position: Vector2, size: float = 1, color: String = "#FFF", prefix: String = ""):
	var number = Label.new()
	number.global_position = position
	number.text = prefix + str(value)
	number.z_index = 5
	number.label_settings = LabelSettings.new()
	
	number.label_settings.font_color = color
	number.label_settings.font_size = 21 * size
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 1
	
	call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y - 24, 0.25
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "position:y", number.position.y, 0.5
	).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
	).set_ease(Tween.EASE_IN).set_delay(0.5)
	
	await tween.finished
	number.queue_free()
	
func _process(delta: float) -> void:
	time_secs += delta
