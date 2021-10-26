extends Node2D


onready var chk_box_music: TextureButton = $ColorRect/VBoxContainer/ChkBoxMusic/CheckBox
onready var chk_box_sound: TextureButton = $ColorRect/VBoxContainer/ChkBoxFx/CheckBox
onready var chk_box_rumble: TextureButton = $ColorRect/VBoxContainer/ChkBoxRumble/CheckBox


func _ready():
	chk_box_rumble.pressed = GameSettings.is_rumble_enabled
	chk_box_sound.pressed = GameSettings.is_fx_enabled
	chk_box_music.pressed = GameSettings.is_music_enabled
	
func _is_left_mouse_click(input: InputEventMouseButton) -> bool:
	return (input is InputEventMouseButton 
	and input.button_index == BUTTON_LEFT 
	and input.pressed)

func _update_settings() -> void:
	GameSettings.is_fx_enabled = chk_box_sound.pressed
	GameSettings.is_music_enabled = chk_box_music.pressed
	GameSettings.is_rumble_enabled = chk_box_rumble.pressed


func _on_ButtonMainMenu_gui_input(event):
	_update_settings()
	if _is_left_mouse_click(event):
		var _x = get_tree().change_scene("res://scenes/StartScreen.tscn")
