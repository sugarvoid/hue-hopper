extends Node

var coins: int
var _score: int
var hearts: int
var multiplier: int 
#var bottom_color: String


func init_data() -> void:
	hearts = 4
	coins = 0
	multiplier = 1
	_score = 0






func get_player_score() -> int:
	return _score

func change_player_score(amount: int) -> void:
	self._score += (amount * multiplier)
	multiplier = 1 # resets multiplier
	if self._score < 0:
		self._score = 0
