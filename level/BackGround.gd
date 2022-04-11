extends Node

var day = "00d4e8"
var eving = "003368"
var eving_o = "b55b00"
var night = "000f10"


func _ready():
	_reset_to_morning()
	Signals.connect("player_finished_easy", self, "_change_color('evening')")

func _reset_to_morning():
	$ColorRect.color = Color(day)

func _tween_color(new_color: String):
	$Tween.interpolate_property($ColorRect, "color", 
		$ColorRect.color, 
		Color(new_color), 10, Tween.TRANS_LINEAR)
	$Tween.start()



func change_color(num: int) -> void:
	match num:
		0:
			_tween_color(day)
		1:
			_tween_color(eving)
		2:
			_tween_color(night)
