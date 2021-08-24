extends Node2D

var on_new_game: bool = false

func _ready():
	PlayerData.hearts = 4
	PlayerData.coins = 0
	PlayerData.score = 0

func _on_NewGame_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		$AudioStreamPlayer.play()
		get_tree().change_scene("res://scenes/Game.tscn")


func _on_Quit_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		get_tree().quit()
