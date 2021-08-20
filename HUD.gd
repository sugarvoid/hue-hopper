extends Control

onready var heart_container: HBoxContainer = $LifeContainer
onready var label: Label = $HBoxContainer2/Order
var p_heart_icon = preload("res://HeartIcon.tscn")

var positions: Array = [
	"RED",
	"BLUE",
	"YELLOW",
	"GREEN"
	#preload("res://ships/enemies/SuicideEnemy.tscn"),
	#preload("res://actors/enemies/ZaggingEnemy.tscn"),
	#preload("res://actors/enemies/TankEnemy.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear_hearts()
	Signals.connect("on_player_life_change", self, "_on_player_life_change")
	Signals.connect("player_has_landed", self, "my_function")

func change_label_text(s: String):
	label.set_text(s)

func clear_hearts():
	for heart in heart_container.get_children():
		heart.queue_free()

func set_hearts(hearts: int):
	clear_hearts()
	for i in range(hearts):
		heart_container.add_child(p_heart_icon.instance())

func my_function(string: String):
	var position: String = positions[randi() % positions.size()]
	change_label_text(position)
	print(string)
	#print("player landed")

func _on_player_life_change(hearts: int):
	set_hearts(hearts)
