extends Node2D

@onready var player: Player = %Player
@onready var tileset := $TileMapLayer

@onready var enemies: Array[Resource] = [
	preload('res://entities/enemy.tscn')
]

const CHUNK_SIZE: Vector2 = Vector2.ONE * 48
const TILE_SIZE: int = 48
const SPAWN_DISTANCE: int = 48
const ENEMY_CAP: int = 20
var noise: FastNoiseLite = FastNoiseLite.new()

func _physics_process(_delta: float) -> void:
	generate_chunk(player.global_position)

func generate_chunk(pivot: Vector2) -> void:
	var coords: Vector2
	var ns: float
	for x in range(CHUNK_SIZE.x):
		for y in range(CHUNK_SIZE.y):
			coords = floor(pivot / TILE_SIZE) + Vector2(x, y) - CHUNK_SIZE / 2
			ns = noise.get_noise_2dv(coords)
			if ns < 0.05:
				tileset.set_cell(coords, 0, Vector2.ZERO)
			else:
				tileset.set_cell(coords, 1, Vector2.ZERO)

func _on_enemy_spawner_timeout() -> void:
	if $Enemies.get_child_count() > ENEMY_CAP: return
	var en: Enemy= enemies.pick_random().instantiate()
	var pos: Vector2 =  Vector2.ONE.rotated(randf_range(0, 2 * PI)) * SPAWN_DISTANCE * TILE_SIZE
	en.global_position = pos + player.global_position
	$Enemies.add_child(en)
