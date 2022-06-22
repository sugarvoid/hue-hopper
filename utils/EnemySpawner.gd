extends Node2D


const BOTTON_RIGHT: Vector2 = Vector2(216, 217)
const BOTTON_LEFT: Vector2 = Vector2(-13, 217)
const TOP_RIGHT: Vector2 = Vector2(216, 180)
const TOP_LEFT: Vector2 = Vector2(-25, 180)
const enemy_options : Array = [
	"_create_spikehead",
	"_create_boxbody",
	"_create_bat",
]

onready var timer = $Timer

var next_spawn_time: float = 4.0
var max_spawn_time: float = 8.0
var min_spawn_time: float = 2.0

func _ready() -> void:
	randomize()
	timer.start(next_spawn_time)

func _create_boxbody() -> Enemy:
	var p_box = preload("res://entity/enemy/BoxBody.tscn")
	var box = p_box.instance()
	box.type = Global.ENEMY_TYPE.BOX 
	box.speed = 30
	box.color = box.get_random_color()
	return box
	
func _create_spikehead() -> Enemy:
	var p_spikehead = preload("res://entity/enemy/SpikeHead.tscn")
	var spikehead = p_spikehead.instance()
	spikehead.speed = 40
	spikehead.type = Global.ENEMY_TYPE.SPIKE 
	return spikehead

func _create_bat():
	var p_bat = preload("res://entity/enemy/Bat.tscn")
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
		
	get_tree().current_scene.add_child(enemy)
	
	max_spawn_time -= 0.15
	next_spawn_time = rand_range(max_spawn_time, min_spawn_time)

	if next_spawn_time < min_spawn_time:
		next_spawn_time = min_spawn_time
		
	timer.start(next_spawn_time)
