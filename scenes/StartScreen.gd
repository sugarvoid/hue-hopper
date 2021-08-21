extends Node2D


func _input(event: InputEvent) -> void:
	if event.is_action_released("pulse"):
		get_tree().change_scene("res://scenes/Game.tscn")

