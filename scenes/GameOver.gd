extends Node2D

func _ready():
	$Label2.set_text("Score: " + str(PlayerData.score))
	$AudioStreamPlayer.play()


func _on_Restart_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		get_tree().change_scene("res://scenes/StartScreen.tscn")
