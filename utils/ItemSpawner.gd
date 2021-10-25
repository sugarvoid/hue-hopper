extends Node2D

var next_spawn_time: float = 5.0

var max_spawn_time: float = 10.0
var min_spawn_time: float = 5.0


enum GameModes {
  EASY,
  MEDIUM,
  HARD,
}

var p_items: Array = [
	preload("res://items/Spike.tscn")
]

onready var timer = $Timer
onready var view_rect := get_viewport_rect()

func _ready() -> void:
	randomize()
	timer.start(next_spawn_time)


func _determine_game_difficulty() -> void:
	var score = PlayerData.get_player_score()
	if score < 100: # easy
		max_spawn_time = 10.0
		min_spawn_time = 5.0
	elif score >= 100 && score < 200: # medium
		max_spawn_time = 8.0
		min_spawn_time = 4.0
	else: # hard
		max_spawn_time = 6.0
		min_spawn_time = 2.0


func _on_Timer_timeout() -> void:
	
	var x_pos := rand_range(view_rect.position.x, view_rect.end.x)
	var random_item = p_items[randi() % p_items.size()]
	var item = random_item.instance()
	item.position = Vector2(x_pos, position.y) 
	get_tree().current_scene.add_child(item) # place item
	
	_determine_game_difficulty()
	
	next_spawn_time = rand_range(max_spawn_time, min_spawn_time)
	timer.start(next_spawn_time)
