extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var chk_box_music: CheckBox = $ColorRect/Panel/VBoxContainer/ChkBoxMusic
onready var chk_box_sound: CheckBox = $ColorRect/Panel/VBoxContainer/ChkBoxSound
onready var chk_box_rumble: CheckBox = $ColorRect/Panel/VBoxContainer/ChkBoxRumble

# Called when the node enters the scene tree for the first time.
func _ready():
	chk_box_rumble.pressed = GameSettings.is_rumble_enabled
	chk_box_sound.pressed = GameSettings.is_fx_enabled
	chk_box_music.pressed = GameSettings.is_music_enabled
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _update_settings() -> void:
	GameSettings.is_fx_enabled = chk_box_sound.pressed
	GameSettings.is_music_enabled = chk_box_music.pressed
	GameSettings.is_rumble_enabled = chk_box_rumble.pressed


func _on_ChkBoxRumble_toggled(button_pressed):
	print("pressed")
	pass # Replace with function body.


func _on_ButtonMainMenu_pressed():
	_update_settings()
	var _x = get_tree().change_scene("res://scenes/StartScreen.tscn")
