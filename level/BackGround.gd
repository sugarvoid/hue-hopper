extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var day = "00d4e8"
var eving = "003368"
var eving_o = "b55b00"
var night = "000f10"

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.color = Color(day)
	#change_color()
	Signals.connect("player_finished_easy", self, "_change_color('evening')")

func change_color(new_color: String):
	$Tween.interpolate_property($ColorRect, "color", 
		$ColorRect.color, 
		Color(new_color), 10, Tween.TRANS_LINEAR)
	$Tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_handle_background_color()

func _handle_background_color() -> void:
	match GameData._current_difficulty:
		GameData.DIFFICULTY.EASY:
			change_color(day)
		GameData.DIFFICULTY.MEDIUM:
			change_color(eving)
		GameData.DIFFICULTY.HARD:
			change_color(night)
