extends Node

const XBOX_BUTTON_TO_INDEX_MAPPING = {
	JOY_XBOX_A: 0,
	JOY_XBOX_B: 1,
	JOY_XBOX_X: 2,
	JOY_XBOX_Y: 3,
	JOY_START: 6,
	JOY_SELECT: 7
}

const KEYBOARD_BUTTON_TO_INDEX_MAPPING = {
	KEY_A: 13,
	KEY_B: 14,
	KEY_C: 15,
	KEY_D: 16,
	KEY_E: 17,
	KEY_F: 18,
	KEY_G: 19,
	KEY_H: 20,
	KEY_I: 21,
	KEY_J: 22,
	KEY_K: 23,
	KEY_L: 24,
	KEY_M: 25,
	KEY_N: 26,
	KEY_O: 27,
	KEY_P: 28,
	KEY_Q: 29,
	KEY_R: 30,
	KEY_S: 31,
	KEY_T: 32,
	KEY_U: 33,
	KEY_V: 34,
	KEY_W: 35,
	KEY_X: 36,
	KEY_Y: 37,
	KEY_Z: 38,
	KEY_ENTER: 39,
	KEY_SPACE: 40,
	KEY_ESCAPE: 41,
}



func create_high_score_file():
	var f = File.new()
	if f.file_exists(GameSettings.high_score_file):
		return
	else:
		f.open(GameSettings.high_score_file, File.WRITE)
		f.store_var(0)
		f.close()



var high_score_file = "user://highscore.txt"

var is_music_enabled: bool = true
var is_fx_enabled: bool = true
var is_fullscreen_enabled: bool = false
var is_rumble_enabled: bool = true

var music_volume: float
var fx_volume: float


