extends Node2D


func _ready():
	pass # Replace with function body.

func _is_left_mouse_click(input: InputEventMouseButton) -> bool:
	return (input is InputEventMouseButton 
	and input.button_index == BUTTON_LEFT 
	and input.pressed)


func _on_BtnMainMenu_gui_input(event):
	if _is_left_mouse_click(event):
		var _x = get_tree().change_scene("res://scenes/StartScreen.tscn")
