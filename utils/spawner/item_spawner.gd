extends Node2D

var next_spawn_time: float = 5.0
var max_spawn_time: float = 10.0
var min_spawn_time: float = 5.0
var positions: Array


onready var p_FallingItem = preload("res://items/FallingItem.tscn")
onready var p_PaintBucket = preload("res://items/PaintBucket.tscn")
onready var timer_spike = $TimerSpike
onready var timer_flask = $TimerFlask
onready var view_rect := get_viewport_rect()


func _ready() -> void:
	Signals.connect("landed_on_wrong_color", self, "_spawn_paint")
	randomize()
	timer_spike.start(next_spawn_time)


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
			min_spawn_time = 2.0


#func _fire_all() -> void:
#	var s = get_tree().current_scene
#
#	#TODO: Add a way for multiple spikes on higher diffity
#	var random_pipe = positions[randi() % positions.size()]
#	var paint_bucket = p_PaintBucket.instance()
#	paint_bucket.position = random_pipe
#	s.call_deferred("add_child", paint_bucket)
#
##	for pos in positions:
##		var spike = p_Spike.instance()
##		spike.position = pos
##		s.call_deferred("add_child", spike)
##		#s.add_child(spike)


func _on_TimerSpike_timeout():
	pass
#	var x_pos := rand_range(view_rect.position.x, view_rect.end.x)
#	var random_item = p_items[randi() % p_items.size()]
#	var item = random_item.instance()
#	#item.position = Vector2(x_pos, position.y) 
#	item.position = positions[randi() % positions.size()]
#	.add_child(item) # place item
#
#	_determine_spawn_rate()
#
#	next_spawn_time = rand_range(max_spawn_time, min_spawn_time)
#	timer_spike.start(next_spawn_time)

func _spawn_paint():
	# GET RANDOM GEM
	# SPWAN GEM
	var x_pos := rand_range(12, 188)
	var bucket = p_FallingItem.instance()
	bucket.position = Vector2(x_pos, 0) 
	bucket.setup(Global.ITEMS.PAINT_BUCKET)
	get_tree().current_scene.add_child(bucket)

func _on_TimerFlask_timeout():
	# GET RANDOM GEM
	# SPWAN GEM
	var x_pos := rand_range(view_rect.position.x, view_rect.end.x)
	var new_flask = p_FallingItem.instance()
	new_flask.setup(Global.ITEMS.FLASK)
	new_flask.position = Vector2(x_pos, position.y) 
	get_tree().current_scene.add_child(new_flask)
	# RESET TIMER
	timer_flask.start(20)

