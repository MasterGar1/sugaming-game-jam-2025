extends Node2D

@onready var tileset := $TileMapLayer

const CHUNK_SIZE: Vector2 = Vector2.ONE * 48
const TILE_SIZE: int = 48
var noise: FastNoiseLite = FastNoiseLite.new()

func _ready() -> void:
	generate_chunk(Vector2.ZERO)
	generate_chunk(Vector2(1000, 0))

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
