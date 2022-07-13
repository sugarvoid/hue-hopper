extends Node

## Game Constants ##
const HIGH_SCORE_FILE: String = "user://highscore.txt"
const prillyBlue: String = "329cc3"
const rubyRed: String = "c13354"
const white: String = "ffffff"
const GAME_VERSION = "1.4.0"
const CORRECT_POINTS: int = 5
const WRONG_POINTS: int = 5


const AUDIO_PATHS: Dictionary = {
	"correct" : "res://sounds/correct.wav",
	"wrong" : "res://sounds/wrong.wav",
	"glass" : "res://sounds/hard-glass-impact.wav",
}

"""
SceenChanges
"""
func go_to_start_screen() -> void:
	var _x = get_tree().change_scene("res://interface/menu/StartScreen.tscn")




static func change_rect_color(rect: ColorRect, color: String) -> void:
	rect.color = color



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

#TODO: Rename to type first, color second
enum ITEMS {
	PAINT_BUCKET,
	BLUE_FLASK,
	ORANGE_FLASK,
	BROWN_FLASK
}

enum ENEMY_TYPE {
	BOX,
	SPIKE,
	BAT
}

# enum COLORS {
# 	RED,
# 	GREEN,
# 	PURPLE,
# 	YELLOW
# }


"""
Player Data
"""
var player_score: int = 0 
var player_hearts: int = 3



func reset_player_stats() -> void:
	player_score = 0


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


# func _on_orb_pickup(debuff_id) -> void:
# 	match debuff_id:
# 		Global.EFFECTS.ROTATION:
# 			_current_debuff = "SLOW DOWN"
# 			PlayerData.rotation_speed = 2.0
# 		Global.EFFECTS.BOUNCE_DOWN:
# 			_current_debuff = "LOW BOUNCE"
# 			PlayerData.bounce_force = 200
# 		Global.EFFECTS.ROTATION_UP:
# 			_current_debuff = "ROTATION UP"
# 		_:
# 			pass
	
# 	debuff_timer.start(10)

#func _remove_EFFECTS():
#	PlayerData.rotation_speed = PlayerData.DEFAULT_ROTATION_SPEED
#	PlayerData.bounce_force = PlayerData.DEFAULT_BOUCE_FORCE

#func _on_debuff_timer_timeout() -> void:
#	_current_debuff = ""
#	_remove_EFFECTS()

func is_left_mouse_click(input: InputEventMouseButton) -> bool:
	return (input is InputEventMouseButton 
	and input.button_index == BUTTON_LEFT 
	and input.pressed)

# Test coment for function
func raise_error(msg: String) -> void:
	assert(false, msg)
