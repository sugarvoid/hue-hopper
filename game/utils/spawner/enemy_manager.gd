class_name EnemyManager
extends Node

signal player_killed_enemy

const p_box = preload("res://game/actor/enemy/BoxBody.tscn")
const p_spikehead = preload("res://game/actor/enemy/SpikeHead.tscn")
const p_bat = preload("res://game/actor/enemy/Bat.tscn")

const BOTTON_RIGHT: Vector2 = Vector2(216, 217)
const BOTTON_LEFT: Vector2 = Vector2(-13, 217)
const TOP_RIGHT: Vector2 = Vector2(216, 180)
const TOP_LEFT: Vector2 = Vector2(-25, 180)
const enemy_options : Array = [
	"_create_spikehead",
	"_create_boxbody",
	"_create_bat",
]

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

func _create_boxbody() -> Enemy:
	var box = p_box.instance()
	box.type = Global.ENEMY_TYPE.BOX 
	box.speed = 30
	box.color = box.get_random_color()
	return box

func _create_spikehead() -> Enemy:
	var spikehead = p_spikehead.instance()
	spikehead.speed = 40
	spikehead.type = Global.ENEMY_TYPE.SPIKE 
	return spikehead

func _create_bat() -> Enemy:
	var bat = p_bat.instance()
	bat.speed = 70
	bat.type = Global.ENEMY_TYPE.BAT
	return bat

func _on_Timer_timeout() -> void:
	var e_func = enemy_options[randi() % enemy_options.size()]
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
