extends Node2D


onready var chk_box_music: CheckBox = $ColorRect/VBoxContainer/ChkBoxMusic
onready var chk_box_sound: CheckBox = $ColorRect/VBoxContainer/ChkBoxSound
onready var chk_box_rumble: CheckBox = $ColorRect/VBoxContainer/ChkBoxRumble


func _ready():
	chk_box_rumble.pressed = GameSettings.is_rumble_enabled
	chk_box_sound.pressed = GameSettings.is_fx_enabled
	chk_box_music.pressed = GameSettings.is_music_enabled
	

func _update_settings() -> void:
	GameSettings.is_fx_enabled = chk_box_sound.pressed
	GameSettings.is_music_enabled = chk_box_music.pressed
	GameSettings.is_rumble_enabled = chk_box_rumble.pressed


func _on_ButtonMainMenu_pressed():
	_update_settings()
	var _x = get_tree().change_scene("res://scenes/StartScreen.tscn")
