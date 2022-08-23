#Enemy Manager: Make, set up, track, and delete enemies

class_name EnemyManager
extends Node

signal player_killed_enemy

var p_SoftHead = preload("res://game/actor/enemy/SoftHead.tscn")
var p_SpikeHead = preload("res://game/actor/enemy/SpikeHead.tscn")
var p_Bat = preload("res://game/actor/enemy/Bat.tscn")

const BOTTON_RIGHT: Vector2 = Vector2(216, 217)
const BOTTON_LEFT: Vector2 = Vector2(-13, 217)
const TOP_RIGHT: Vector2 = Vector2(216, 180)
const TOP_LEFT: Vector2 = Vector2(-25, 180)
const ENEMY_OPTIONS : Array = [
	"_create_spikehead",
	"_create_softhead",
	"_create_bat",
]
const SOFT_HEAD_SPEED: int = 50
const SPIKE_HEAD_SPEED: int = 30
const BAT_SPEED: int = 70

onready var timer = get_node("SpawnTimer")

var next_spawn_time: float = 3.0
var max_spawn_time: float = 5.0
var min_spawn_time: float = 2.0

func _ready() -> void:
	randomize()
	timer.start(next_spawn_time)

func _connect_child_signals(child: Enemy) -> void:
	child.connect("player_killed_me", self, "_on_player_killed_enemy")
	connect(child.player_killed_enemy, self, "test_func")

func test_func():
	print("DING!!!!!!")

func _on_player_killed_enemy() -> void:
	emit_signal("player_killed_ememy")

func _create_softhead() -> Enemy:
	var soft_head = p_SoftHead.instance()
	soft_head.type = Global.ENEMY_TYPE.BOX 
	soft_head.speed = SOFT_HEAD_SPEED
	soft_head.color = soft_head.get_random_color()
	return soft_head

func _create_spikehead() -> Enemy:
	var spike_head = p_SpikeHead.instance()
	spike_head.speed = SPIKE_HEAD_SPEED
	spike_head.type = Global.ENEMY_TYPE.SPIKE 
	return spike_head

func _create_bat() -> Enemy:
	var bat = p_Bat.instance()
	bat.speed = BAT_SPEED
	bat.type = Global.ENEMY_TYPE.BAT
	return bat

func remove_all_enemies() -> void:
	pass
	#TODO: Add container for all enenmy. Loop through and remove them 

func _on_Timer_timeout() -> void:
	#TODO: rename varibles
	var e_func = ENEMY_OPTIONS[randi() % ENEMY_OPTIONS.size()]
	var enemy: Enemy = call(e_func)
	var sides = [0,1]
	var rand_side:int = randi() % sides.size()
	
	if rand_side == 0:
		enemy.diriction = 1
		if enemy.type == Global.ENEMY_TYPE.BAT:
			enemy.position = TOP_LEFT
		else:
			enemy.position = BOTTON_LEFT
		
	if rand_side == 1:
		enemy.diriction = -1
		if enemy.type == Global.ENEMY_TYPE.BAT:
			enemy.position = TOP_RIGHT
		else:
			enemy.position = BOTTON_RIGHT
		
	add_child(enemy)
	
	max_spawn_time -= 0.15
	next_spawn_time = rand_range(max_spawn_time, min_spawn_time)

	if next_spawn_time < min_spawn_time:
		next_spawn_time = min_spawn_time
		
	timer.start(next_spawn_time)
