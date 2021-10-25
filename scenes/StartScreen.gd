extends Node2D


func _ready():
	PlayerData.init_data()


func _is_left_mouse_click(input: InputEventMouseButton) -> bool:
	return (input is InputEventMouseButton 
	and input.button_index == BUTTON_LEFT 
	and input.pressed)


func _on_DemoQuit_gui_input(event):
	pass # Replace with function body.


func _on_BtnSettings_gui_input(event):
	if _is_left_mouse_click(event):
		var _x = get_tree().change_scene("res://scenes/GameSettings.tscn")


func _on_BtnPlay_gui_input(event):
	if _is_left_mouse_click(event):
		$AudioStreamPlayer.play()
		var _x = get_tree().change_scene("res://scenes/Game.tscn")


func _on_BtnQuit_gui_input(event):
	if _is_left_mouse_click(event):
		get_tree().quit()
