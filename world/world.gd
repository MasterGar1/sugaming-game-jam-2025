extends Node2D

@onready var player: Player = %Player
@onready var tileset := $TileMapLayer
@onready var enemies := $Enemies

@onready var enemy_types: Array[Resource] = [
	preload('res://entities/enemies/melee_mob.tscn'),
	preload('res://entities/enemies/ranged_mob.tscn'),
	preload('res://entities/enemies/melee_elite.tscn'),
	preload('res://entities/enemies/ranged_elite.tscn'),
	preload('res://entities/enemies/fat_guy.tscn'),
]

var weights: Array[float] = [0.5, 0.3, 0.2, 0.2, 0.1]

const TILE_SIZE: int = 48
const CHUNK_SIZE: Vector2 = Vector2.ONE * TILE_SIZE
const SPAWN_DISTANCE: int = 48
const ENEMY_CAP: int = 2
var noise: FastNoiseLite = FastNoiseLite.new()
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

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
	if enemies.get_child_count() > ENEMY_CAP: return
	var en: Enemy = enemy_types[rng.rand_weighted(weights)].instantiate()
	var pos: Vector2 =  Vector2.ONE.rotated(randf_range(0, 2 * PI)) * SPAWN_DISTANCE * TILE_SIZE
	en.global_position = pos + player.global_position
	enemies.add_child(en)
