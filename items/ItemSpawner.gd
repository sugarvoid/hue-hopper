extends Node2D



var next_spawn_time: float = 5.0

var p_items: Array = [
	preload("res://items/Coin.tscn")
]


onready var timer = $Timer

func _ready() -> void:
	randomize()
	timer.start(next_spawn_time)

func _on_Timer_timeout() -> void:
	var view_rect := get_viewport_rect()
	var x_pos := rand_range(view_rect.position.x, view_rect.end.x)
	var random_item = p_items[randi() % p_items.size()]
	var item = random_item.instance()
	item.position = Vector2(x_pos, position.y)
	get_tree().current_scene.add_child(item)
	timer.start(next_spawn_time)
