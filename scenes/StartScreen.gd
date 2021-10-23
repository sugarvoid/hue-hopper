extends Node2D


func _ready():
	PlayerData.init_data()


func _on_NewGame_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		$AudioStreamPlayer.play()
		var _x = get_tree().change_scene("res://scenes/Game.tscn")

func _on_Quit_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		get_tree().quit()

func _on_NewGame_mouse_entered():
	Global.change_rect_color($NewGame, Global.rubyRed)

func _on_NewGame_mouse_exited():
	Global.change_rect_color($NewGame, Global.white)

func _on_Quit_mouse_entered():
	Global.change_rect_color($Quit, Global.rubyRed)

func _on_Quit_mouse_exited():
	Global.change_rect_color($Quit, Global.white)
