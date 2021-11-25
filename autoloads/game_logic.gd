extends Node

const EASY_MAX_SCORE: int = 100
const MED_MIN_SCORE: int = 101
const MED_MAX_SCORE: int = 200
const HARD_MIN_SCORE: int = 201

const CORRECT_POINTS: int = 1
const WRONG_POINTS: int = 5

enum DIFFICULTY {
	EASY,
	MEDIUM,
	HARD
}

enum BUFFS {
	HEALTH_UP,
	REPLACE
}

enum DEBUFFS {
	ROTATION,
	BOUNCE_DOWN,
	ROTATION_UP,
}

enum PICKUPS {
	SPIKE,
	COIN,
	GEM
}

const ITEMS: Dictionary = {
	"coin" : 0
}

var _current_difficulty = DIFFICULTY.EASY
var _current_debuff: String

var has_morning_passed: bool = false
var has_evening_passed: bool = false

onready var debuff_timer: Timer = Timer.new()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_console"):
		get_parent().add_child(load("res://debug/Console.tscn").instance())
		get_tree().paused = true

func _ready():
	GameSettings.create_high_score_file()
	add_child(debuff_timer)
	Signals.connect("apply_debuff", self, "_apply_debuff")
	debuff_timer.connect("timeout", self, "_on_debuff_timer_timeout")
	pass

	
func _determine_game_difficulty() -> void:
	var score = PlayerData.get_player_score()
	if score < EASY_MAX_SCORE:
		_current_difficulty = DIFFICULTY.EASY
	elif score >= MED_MIN_SCORE && score < MED_MAX_SCORE:
		_current_difficulty = DIFFICULTY.MEDIUM
	else:
		_current_difficulty = DIFFICULTY.HARD
		
		
func get_current_difficulty() -> int:
	_determine_game_difficulty()
	return _current_difficulty
	

func get_current_debuff() -> String:
	return "Debuff: " + self._current_debuff

func _apply_debuff(debuff_id) -> void:
	match debuff_id:
		DEBUFFS.ROTATION:
			_current_debuff = "SLOW DOWN"
			PlayerData.rotation_speed = 2.0
		DEBUFFS.BOUNCE:
			_current_debuff = "LOW BOUNCE"
			pass
	
	debuff_timer.start(10)

func _remove_debuffs():
	PlayerData.rotation_speed = PlayerData.DEFAULT_ROTATION_SPEED

func _on_debuff_timer_timeout() -> void:
	_current_debuff = ""
	_remove_debuffs()
