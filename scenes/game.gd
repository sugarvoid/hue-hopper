extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_color: String = "Yellow"

var colors: Array = [
	"Red",
	"Purple",
	"Yellow",
	"Green"
]



# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.emit_signal("color_changed", current_color) # Set color label to default player bottom
	Signals.connect("player_has_landed_on_ground", self, "_player_landed")
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _get_new_color() -> void:
	current_color = colors[randi() % colors.size()]

func _player_landed(player_color) -> void:
	print("poop")
	# COMPARE PLAYER BOTTON TO GAME'S COLOR
	print(self.current_color == player_color)
	# GET NEW COLOR
	_get_new_color()
	# SEND HUD NEW COLOR
	Signals.emit_signal("color_changed", current_color)
