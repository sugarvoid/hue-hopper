extends Node2D

var GuiHelper = preload("res://utils/gui_helper.gd")

func _ready():
	$Label2.set_text("Score: " + str(PlayerData.get_player_score()))
	$AudioStreamPlayer.play()


func _on_Restart_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		get_tree().change_scene("res://scenes/StartScreen.tscn")


func _on_Restart_mouse_entered():
	GuiHelper.change_rect_color($Restart, GuiHelper.rubyRed)
	pass # Replace with function body.


func _on_Restart_mouse_exited():
	GuiHelper.change_rect_color($Restart, GuiHelper.white)
	pass # Replace with function body.
