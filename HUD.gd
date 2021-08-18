extends Control

onready var heart_container: HBoxContainer = $HBoxContainer2/LifeContainer
var p_heart_icon = preload("res://HeartIcon.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear_hearts()
	Signals.connect("on_player_life_change", self, "_on_player_life_change")

func clear_hearts():
	for heart in heart_container.get_children():
		heart.queue_free()

func set_hearts(hearts: int):
	clear_hearts()
	for i in range(hearts):
		heart_container.add_child(p_heart_icon.instance())

func _on_player_life_change(hearts: int):
	set_hearts(hearts)
