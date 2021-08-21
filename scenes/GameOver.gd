extends Node2D

func _input(event: InputEvent) -> void:
	if event.is_action_released("restart"):
		get_tree().change_scene("res://scenes/StartScreen.tscn")
