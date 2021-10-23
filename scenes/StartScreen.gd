extends Node2D


func _ready():
	PlayerData.init_data()

var GuiHelper = preload("res://utils/gui_helper.gd")

func _on_NewGame_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		$AudioStreamPlayer.play()
		var _x = get_tree().change_scene("res://scenes/Game.tscn")

func _on_Quit_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		get_tree().quit()

func _on_NewGame_mouse_entered():
	GuiHelper.change_rect_color($NewGame, GuiHelper.rubyRed)

func _on_NewGame_mouse_exited():
	GuiHelper.change_rect_color($NewGame, GuiHelper.white)

func _on_Quit_mouse_entered():
	GuiHelper.change_rect_color($Quit, GuiHelper.rubyRed)

func _on_Quit_mouse_exited():
	GuiHelper.change_rect_color($Quit, GuiHelper.white)
