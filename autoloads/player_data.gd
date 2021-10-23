extends Node

var coins: int
var _score: int
var hearts: int
#var bottom_color: String


func init_data() -> void:
	hearts = 3
	coins = 0
	_score = 0

func get_player_score() -> int:
	return _score

func change_player_score(amount: int) -> void:
	self._score += amount
