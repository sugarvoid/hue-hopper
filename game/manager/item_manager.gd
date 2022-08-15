class_name ItemManager
extends Node2D

const p_FallingItem = preload("res://game/item/FallingItem.tscn")
onready var timer_flask = $TimerFlask
onready var view_rect := get_viewport_rect()

var next_spawn_time: float = 5.0
var max_spawn_time: float = 10.0
var min_spawn_time: float = 5.0
var positions: Array


func _ready() -> void:
	randomize()

func _determine_spawn_rate() -> void:
	match Global.get_current_difficulty():
		Global.DIFFICULTY.EASY:
			max_spawn_time = 10.0
			min_spawn_time = 5.0
		Global.DIFFICULTY.MEDIUM:
			max_spawn_time = 8.0
			min_spawn_time = 4.0
		Global.DIFFICULTY.HARD:
			max_spawn_time = 6.0
			min_spawn_time = 1.0

func _on_TimerFlask_timeout() -> void:
	var x_pos := rand_range(view_rect.position.x, view_rect.end.x)
	var new_flask = p_FallingItem.instance()
	new_flask.setup(Global.choose([Global.ITEMS.FLASK_ORANGE, Global.ITEMS.FLASK_BLUE, Global.ITEMS.FLASK_WHITE]))
	new_flask.position = Vector2(x_pos, position.y) 
	add_child(new_flask)
	# RESET TIMER
	next_spawn_time = rand_range(min_spawn_time, max_spawn_time)
	timer_flask.start(next_spawn_time)

