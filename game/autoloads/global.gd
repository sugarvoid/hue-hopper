extends Node

enum DIFFICULTY {
	EASY,
	MEDIUM,
	HARD
}

enum EFFECTS {
	ROTATION_DOWN,
	BOUNCE_DOWN,
	ROTATION_UP,
	WHITE_OUT,
	HEALTH_UP
}

enum ITEMS {
	PAINT_BUCKET,
	FLASK_BLUE,
	FLASK_ORANGE,
}

enum ENEMY_TYPE {
	BOX,
	SPIKE,
	BAT
}


"""
Game Constants
"""
const HIGH_SCORE_FILE: String = "user://highscore.txt"
const prillyBlue: String = "329cc3"
const rubyRed: String = "c13354"
const white: String = "ffffff"
const GAME_VERSION = "1.4.0"
const CORRECT_POINTS: int = 5
const WRONG_POINTS: int = 5
const AUDIO_PATHS: Dictionary = {
	"correct" : "res://game/sound/correct.wav",
	"wrong" : "res://game/sound/wrong.wav",
	"glass" : "res://game/sound/hard-glass-impact.wav",
}
const SCENE_PATHS: Dictionary = {
	"game_over" : "res://game/interface/menu/GameOver.tscn",
	"start_screen" : "res://game/interface/menu/StartScreen.tscn",
}

var _x
var is_game_over: bool 

"""
SceenChanges
"""
func go_to_start_screen() -> void:
	_x = get_tree().change_scene(self.SCENE_PATHS.start_screen)

func go_to_gameover_screen() -> void:
	_x = get_tree().change_scene(self.SCENE_PATHS.game_over)

static func change_rect_color(rect: ColorRect, color: String) -> void:
	rect.color = color


"""
Player Data
"""
var player_score: int = 0 
var player_hearts: int = 3
var _current_debuff: String
var is_music_enabled: bool = true
var is_fx_enabled: bool = true
var is_fullscreen_enabled: bool = false
var is_rumble_enabled: bool = true
var music_volume: float
var fx_volume: float
var current_color: int 

func reset_player_stats() -> void:
	player_score = 0

func _ready():
	Global.create_high_score_file()

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

func is_left_mouse_click(input: InputEventMouseButton) -> bool:
	return (input is InputEventMouseButton 
	and input.button_index == BUTTON_LEFT 
	and input.pressed)

func raise_error(msg: String) -> void:
	assert(false, msg)
