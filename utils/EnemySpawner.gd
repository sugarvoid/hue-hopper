extends Node2D

var next_spawn_time: float = 4.0
var max_spawn_time: float = 10.0
var min_spawn_time: float = 3.0
const RIGHT_SIDE: Vector2 = Vector2(216, 217)
const LEFT_SIDE: Vector2 = Vector2(-25, 217)


const enemy_options : Array = [
	"_create_spikehead",
	"_create_boxbody",
]

onready var timer = $Timer

func _ready() -> void:
	randomize()
	timer.start(next_spawn_time)

func _create_boxbody() -> Enemy:
	var p_box = preload("res://entity/enemy/BoxBody.tscn")
	var box = p_box.instance()
	box.type = GameEnums.ENEMY_TYPE.BOX 
	box.speed = 30
	box.color = box.get_random_color()
	return box
	
func _create_spikehead() -> Enemy:
	var p_spikehead = preload("res://entity/enemy/SpikeHead.tscn")
	var spikehead = p_spikehead.instance()
	spikehead.speed = 40
	spikehead.type = GameEnums.ENEMY_TYPE.SPIKE 
	return spikehead

func _create_bat():
	pass

func _on_Timer_timeout() -> void:
	
	var e_func = enemy_options[randi() % enemy_options.size()]
	var enemy: Enemy = call(e_func)
	
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
