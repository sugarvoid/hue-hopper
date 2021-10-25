extends Node2D

var next_spawn_time: float = 5.0

var max_spawn_time: float = 10.0
var min_spawn_time: float = 3.0


enum GameModes {
  EASY,
  MEDIUM,
  HARD,
}

var p_items: Array = [
	preload("res://items/Spike.tscn")
]

onready var timer = $Timer

func _ready() -> void:
	randomize()
	timer.start(next_spawn_time)


func determine_game_difficulty() -> void:
	var score = PlayerData.get_player_score()
	if score < 100:
		pass
	elif score >= 100 && score < 200:
		pass
	else:
		pass


func _on_Timer_timeout() -> void:
	var view_rect := get_viewport_rect()
	var x_pos := rand_range(view_rect.position.x, view_rect.end.x)
	var random_item = p_items[randi() % p_items.size()]
	var item = random_item.instance()
	item.position = Vector2(x_pos, position.y)
	get_tree().current_scene.add_child(item)
	max_spawn_time -= 0.2
	if max_spawn_time < min_spawn_time:
		max_spawn_time = min_spawn_time
	next_spawn_time = rand_range(max_spawn_time, min_spawn_time)
	timer.start(next_spawn_time)
