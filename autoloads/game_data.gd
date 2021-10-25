extends Node

enum DIFFICULTY {
	EASY,
	MEDIUM,
	HARD
}

enum DEBUFFS {
	ROTATION,
	BOUNCE
}

enum PICKUPS {
	SPIKE,
	COIN,
	GEM
}

var _current_difficulty = DIFFICULTY.EASY

var has_morning_passed: bool = false
var has_evening_passed: bool = false

func _ready():
	pass

	
func _determine_game_difficulty() -> void:
	var score = PlayerData.get_player_score()
	if score < 60:
		_current_difficulty = DIFFICULTY.EASY
	elif score >= 60 && score < 150:
		_current_difficulty = DIFFICULTY.MEDIUM
	else:
		_current_difficulty = DIFFICULTY.HARD
		
		
func get_current_difficulty() -> int:
	_determine_game_difficulty()
	return _current_difficulty
	
func _apply_debuff() -> void:
	pass
