extends Node


"""
Player Data/Stats
"""
var bounce_force: float = DEFAULT_BOUCE_FORCE
var rotation_speed: float = DEFAULT_ROTATION_SPEED
var jump_force: float
var coins: int
var _score: int
var hearts: int
var multiplier: int 
const DEFAULT_ROTATION_SPEED: float = 4.5
const DEFAULT_BOUCE_FORCE: float = 400.00


"""
Functions
"""
func init_player_data() -> void:
	hearts = 3
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
