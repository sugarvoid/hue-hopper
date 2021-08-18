extends Node2D

onready var timer = $Timer
var next_spawn_time: float = 3.0
var p_items: Array = [
	preload("res://items/Coin.tscn")
]
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	timer.start(next_spawn_time)
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Timer_timeout() -> void:
	var view_rect := get_viewport_rect()
	var x_pos := rand_range(view_rect.position.x, view_rect.end.x)
	var random_item = p_items[randi() % p_items.size()]
	var item = random_item.instance()
	item.position = Vector2(x_pos, position.y)
	get_tree().current_scene.add_child(item)
	timer.start(next_spawn_time)
	#pass # Replace with function body.
