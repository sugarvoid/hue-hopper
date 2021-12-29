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

var positions: Array

var p_items: Array = [
	preload("res://items/Spike.tscn")
]

var p_Spike = preload("res://items/Spike.tscn")
var p_Orb = preload("res://Orb.tscn")

onready var pipes = get_tree().get_root().get_node("Game/Level/Pipes")


onready var timer_spike = $TimerSpike
onready var timer_orb = $TimerOrb
onready var view_rect := get_viewport_rect()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pulse"):
		_fire_all()

func get_pipe_pos() -> void:
	for pipe in pipes.get_children():
		positions.push_back(pipe.global_position)

func _ready() -> void:
	Signals.connect("on_red_button_pressed", self, "_fire_all")
	get_pipe_pos()
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


func _fire_all() -> void:
	var s = get_tree().current_scene
	
	
	var random_pipe = positions[randi() % positions.size()]
	var spike = p_Spike.instance()
	spike.position = random_pipe
	s.call_deferred("add_child", spike)
	
#	for pos in positions:
#		var spike = p_Spike.instance()
#		spike.position = pos
#		s.call_deferred("add_child", spike)
#		#s.add_child(spike)


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


func _on_TimerGem_timeout():
	# GET RANDOM GEM
	# SPWAN GEM
	var x_pos := rand_range(view_rect.position.x, view_rect.end.x)
	var new_orb = p_Orb.instance()
	new_orb.orb_id = _get_random_orb_id()
	new_orb.position = Vector2(x_pos, position.y) 
	get_tree().current_scene.add_child(new_orb)
	# RESET TIMER
	timer_orb.start(10)
	#FIXME: Replace timer back to 20 

func _get_random_orb_id() -> int:
	var _ran: int = rand_range(0, 3)
	return GameLogic.DEBUFFS.BOUNCE_DOWN
