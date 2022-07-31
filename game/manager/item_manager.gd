class_name ItemManager
extends Node2D

var next_spawn_time: float = 5.0
var max_spawn_time: float = 10.0
var min_spawn_time: float = 5.0
var positions: Array


onready var p_FallingItem = preload("res://game/item/FallingItem.tscn")
onready var timer_flask = $TimerFlask
onready var view_rect := get_viewport_rect()



func _ready() -> void:
	Signals.connect("landed_on_wrong_color", self, "spawn_paint")
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


func spawn_paint(container: Node2D):
	print(container)
	# GET RANDOM GEM
	# SPWAN GEM
	var x_pos := rand_range(12, 188)
	var bucket = p_FallingItem.instance()
	bucket.position = Vector2(x_pos, 0) 
	bucket.setup(Global.ITEMS.PAINT_BUCKET)
	container.add_child(bucket)
	#container.call_deferred("add child", bucket)
	

func _on_TimerFlask_timeout():
	# GET RANDOM GEM
	# SPWAN GEM
	var x_pos := rand_range(view_rect.position.x, view_rect.end.x)
	var new_flask = p_FallingItem.instance()
	new_flask.setup(Global.ITEMS.ORANGE_FLASK)
	new_flask.position = Vector2(x_pos, position.y) 
	get_tree().current_scene.add_child(new_flask)
	# RESET TIMER
	next_spawn_time = rand_range(min_spawn_time, max_spawn_time)
	timer_flask.start(next_spawn_time)

