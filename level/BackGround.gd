extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var day = "00d4e8"
var eving = "003368"
var eving_o = "b55b00"
var night = "000f10"


func _ready():
	$ColorRect.color = Color(day)
	Signals.connect("player_finished_easy", self, "_change_color('evening')")

func change_color(new_color: String):
	$Tween.interpolate_property($ColorRect, "color", 
		$ColorRect.color, 
		Color(new_color), 10, Tween.TRANS_LINEAR)
	$Tween.start()


func _process(delta):
	_handle_background_color()

func _handle_background_color() -> void:
	match GameLogic._current_difficulty:
		GameLogic.DIFFICULTY.EASY:
			change_color(day)
		GameLogic.DIFFICULTY.MEDIUM:
			change_color(eving)
		GameLogic.DIFFICULTY.HARD:
			change_color(night)
