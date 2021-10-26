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

onready var debuff_timer: Timer = Timer.new()


func _ready():
	Signals.connect("apply_debuff", self, "_apply_debuff")
	debuff_timer.connect("timeout", self, "_on_debuff_timer_timeout")
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
	
func _apply_debuff(debuff_id) -> void:
	match debuff_id:
		0:
			PlayerData.rotation_speed = 3.0
		1:
			pass
	add_child(debuff_timer)
	debuff_timer.start(10)

func _remove_debuffs():
	PlayerData.rotation_speed = PlayerData.DEFAULT_ROTATION_SPEED

func _on_debuff_timer_timeout() -> void:
	_remove_debuffs()
