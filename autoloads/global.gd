extends Node

## Constants ##
const HIGH_SCORE_FILE = "user://highscore.txt"

const GAME_VERSION = "1.4.0"
const CORRECT_POINTS: int = 5
const WRONG_POINTS: int = 5
const ITEMS: Dictionary = {
	"coin" : 0
}

onready var debuff_timer: Timer = Timer.new()

## Enums ##
enum BUFFS {
	HEALTH_UP,
	REPLACE
}

enum DIFFICULTY {
	EASY,
	MEDIUM,
	HARD
}

enum DEBUFFS {
	ROTATION,
	BOUNCE_DOWN,
	ROTATION_UP,
	WHITE_OUT,
}

enum PICKUPS {
	SPIKE,
	COIN,
	GEM,
	ORB
}

enum ENEMY_TYPE {
	BOX,
	SPIKE,
	BAT
}

enum COLORS {
	RED,
	GREEN,
	PURPLE,
	YELLOW
}


var _current_debuff: String
var is_music_enabled: bool = true
var is_fx_enabled: bool = true
var is_fullscreen_enabled: bool = false
var is_rumble_enabled: bool = true
var music_volume: float
var fx_volume: float
var current_color: int 



func _ready():
	Global.create_high_score_file()
	add_child(debuff_timer)
	Signals.connect("on_orb_pickup", self, "_on_orb_pickup")
	debuff_timer.connect("timeout", self, "_on_debuff_timer_timeout")
	pass


func create_high_score_file():
	var f = File.new()
	if f.file_exists(Global.HIGH_SCORE_FILE):
		return
	else:
		f.open(Global.HIGH_SCORE_FILE, File.WRITE)
		f.store_var(0)
		f.close()



func get_current_debuff() -> String:
	return "Debuff: " + self._current_debuff


func _on_orb_pickup(debuff_id) -> void:
	match debuff_id:
		Global.DEBUFFS.ROTATION:
			_current_debuff = "SLOW DOWN"
			PlayerData.rotation_speed = 2.0
		Global.DEBUFFS.BOUNCE_DOWN:
			_current_debuff = "LOW BOUNCE"
			PlayerData.bounce_force = 200
		Global.DEBUFFS.ROTATION_UP:
			_current_debuff = "ROTATION UP"
		_:
			pass
	
	debuff_timer.start(10)

func _remove_debuffs():
	PlayerData.rotation_speed = PlayerData.DEFAULT_ROTATION_SPEED
	PlayerData.bounce_force = PlayerData.DEFAULT_BOUCE_FORCE

func _on_debuff_timer_timeout() -> void:
	_current_debuff = ""
	_remove_debuffs()

func is_left_mouse_click(input: InputEventMouseButton) -> bool:
	return (input is InputEventMouseButton 
	and input.button_index == BUTTON_LEFT 
	and input.pressed)
