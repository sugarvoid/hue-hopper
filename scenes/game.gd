extends Node

const MISS: int = -10
const HIT: int = 5

var current_color: String = "Yellow"

var colors: Array = [
	"Red",
	"Purple",
	"Yellow",
	"Green"
]


func _ready():
	Signals.emit_signal("color_changed", current_color) # Set color label to default player bottom
	Signals.connect("player_has_landed_on_ground", self, "_player_landed")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _get_new_color() -> void:
	current_color = colors[randi() % colors.size()]

func _player_landed(player_color) -> void:

	# COMPARE PLAYER BOTTON TO GAME'S COLOR
	if self.current_color == player_color:
		$SoundRight.play()
		PlayerData.change_player_score(HIT)
	else:
		$SoundWrong.play()
		PlayerData.change_player_score(MISS)
	print(self.current_color == player_color)
	Signals.emit_signal("player_stat_changed")
	# GET NEW COLOR
	_get_new_color()
	# SEND HUD NEW COLOR
	Signals.emit_signal("color_changed", current_color)
