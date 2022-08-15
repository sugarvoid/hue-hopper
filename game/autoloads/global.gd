extends Node


enum ITEMS {
	FLASK_BLUE,
	FLASK_ORANGE,
	FLASK_WHITE,
}

enum ENEMY_TYPE {
	BOX,
	SPIKE,
	BAT
}


const HIGH_SCORE_FILE: String = "user://highscore.txt"
const prillyBlue: String = "329cc3"
const rubyRed: String = "c13354"
const white: String = "ffffff"
const GAME_VERSION = "0.5.1"
const SCENE_PATHS: Dictionary = {
	"game_over" : "res://game/interface/menu/GameOver.tscn",
	"start_screen" : "res://game/interface/menu/StartScreen.tscn",
}

var _x


"""
SceenChanges
"""
func go_to_start_screen() -> void:
	_x = get_tree().change_scene(self.SCENE_PATHS.start_screen)



static func change_rect_color(rect: ColorRect, color: String) -> void:
	rect.color = color


var is_music_enabled: bool = true
var is_fx_enabled: bool = true
var is_fullscreen_enabled: bool = false
var is_rumble_enabled: bool = true
var music_volume: float
var fx_volume: float
var player_score: int

func _ready():
	randomize()
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
	
func choose(array):
	return array[randi() % array.size()]
