extends Node2D

var next_spawn_time: float = 4.0
var max_spawn_time: float = 10.0
var min_spawn_time: float = 3.0
const RIGHT_SIDE: Vector2 = Vector2(216, 217)
const LEFT_SIDE: Vector2 = Vector2(-25, 217)

var p_enemies: Array = [
	preload("res://entity/enemy/Enemy.tscn")
]

onready var timer = $Timer

func _ready() -> void:
	randomize()
	timer.start(next_spawn_time)

func _on_Timer_timeout() -> void:
	var random_enemy = p_enemies[randi() % p_enemies.size()]
	
	var enemy: Enemy = random_enemy.instance()
	enemy.color = enemy.get_random_color()
	
	
	var sides = [0,1]
	var rand_side:int = randi() % sides.size()
	
	if rand_side == 0:
		enemy.position = LEFT_SIDE
		enemy.diriction = 1
	elif rand_side == 1:
		enemy.position = RIGHT_SIDE
		enemy.diriction = -1
		
	get_tree().current_scene.add_child(enemy)
	
	max_spawn_time -= 0.25
	next_spawn_time = rand_range(max_spawn_time, min_spawn_time)

	if next_spawn_time < min_spawn_time:
		next_spawn_time = min_spawn_time
	timer.start(next_spawn_time)
