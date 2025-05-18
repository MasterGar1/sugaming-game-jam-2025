extends Node2D

@onready var player: Player = %Player
@onready var ground := $Ground
@onready var objects := $Objects
@onready var enemies := $Enemies
@onready var gui := $GUI
@onready var enemy_types: Array[Resource] = [
	preload('res://entities/enemies/melee_mob.tscn'),
	preload('res://entities/enemies/ranged_mob.tscn'),
	preload('res://entities/enemies/melee_elite.tscn'),
	preload('res://entities/enemies/ranged_elite.tscn'),
	preload('res://entities/enemies/fat_guy.tscn'),
]

@export var noise1: FastNoiseLite
@export var noise2: FastNoiseLite

var weights: Array[float] = [0.5, 0.3, 0.2, 0.2, 0.1]

const TILE_SIZE: int = 48
const CHUNK_SIZE: Vector2 = Vector2.ONE * TILE_SIZE
const SPAWN_DISTANCE: int = 48
const ENEMY_CAP: int = 2
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _physics_process(_delta: float) -> void:
	generate_chunk(player.global_position)

func generate_chunk(pivot: Vector2) -> void:
	var coords: Vector2
	var ns1: float
	var ns2: float
	for x in range(CHUNK_SIZE.x):
		for y in range(CHUNK_SIZE.y):
			coords = floor(pivot / TILE_SIZE) + Vector2(x, y) - CHUNK_SIZE / 2
			if ground.get_cell_source_id(coords) > 0: continue
			ns1 = noise1.get_noise_2dv(coords)
			ns2 = noise2.get_noise_2dv(coords)
			ground.set_cell(coords, 0 if ns1 < 0.05 else 1, Vector2.ZERO)
			if ((ns1 > 0.1 and ns1 < 0.2) or (ns1 < -0.1 and ns1 > -0.2)) and ns2 > 0.85:
				objects.set_cell(coords, floori(abs(ns1) * 100) % 8, Vector2.ZERO)

func _on_enemy_spawner_timeout() -> void:
	if enemies.get_child_count() > ENEMY_CAP: return
	var en: Enemy = enemy_types[rng.rand_weighted(weights)].instantiate()
	var pos: Vector2 =  Vector2.ONE.rotated(randf_range(0, 2 * PI)) * SPAWN_DISTANCE * TILE_SIZE
	en.global_position = pos + player.global_position
	enemies.add_child(en)
