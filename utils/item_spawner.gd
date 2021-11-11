extends Node2D

var next_spawn_time: float = 5.0
var max_spawn_time: float = 10.0
var min_spawn_time: float = 5.0

# TODO: Check to see if this can be removed
enum GameModes {
  EASY,
  MEDIUM,
  HARD,
}

var p_items: Array = [
	preload("res://items/Spike.tscn")
]

var Gem = preload("res://items/Gem.tscn")

onready var timer_spike = $TimerSpike
onready var timer_gem = $TimerGem
onready var view_rect := get_viewport_rect()

func _ready() -> void:
	randomize()
	timer_spike.start(next_spawn_time)


func _determine_spawn_rate() -> void:
	match GameLogic.get_current_difficulty():
		GameLogic.DIFFICULTY.EASY:
			max_spawn_time = 10.0
			min_spawn_time = 5.0
		GameLogic.DIFFICULTY.MEDIUM:
			max_spawn_time = 8.0
			min_spawn_time = 4.0
		GameLogic.DIFFICULTY.HARD:
			max_spawn_time = 6.0
			min_spawn_time = 2.0



func _on_TimerSpike_timeout():
	var x_pos := rand_range(view_rect.position.x, view_rect.end.x)
	var random_item = p_items[randi() % p_items.size()]
	var item = random_item.instance()
	item.position = Vector2(x_pos, position.y) 
	get_tree().current_scene.add_child(item) # place item
	
	_determine_spawn_rate()
	
	next_spawn_time = rand_range(max_spawn_time, min_spawn_time)
	timer_spike.start(next_spawn_time)


func _on_TimerGem_timeout():
	# GET RANDOM GEM
	# SPWAN GEM
	var x_pos := rand_range(view_rect.position.x, view_rect.end.x)
	var new_gem = Gem.instance()
	new_gem.debuff_id = 0
	new_gem.position = Vector2(x_pos, position.y) 
	get_tree().current_scene.add_child(new_gem)
	# RESET TIMER
	timer_gem.start(20)
	pass
