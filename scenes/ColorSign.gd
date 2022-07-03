extends Node2D


onready var sprite = get_node("Sprite")
# var b = "text"
export var color : int 


func set_color(number: int) -> void:
	self.sprite = number

func _ready():
	pass



