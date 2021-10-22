extends Node2D

var on_new_game: bool = false

const prillyBlue: String = "329cc3"
const rubyRed: String = "c13354"
const white: String = "ffffff"

func _ready():
	PlayerData.init_data()

func change_rect_color(rect: ColorRect, color: String) -> void:
	rect.color = color

func reset_rect_color(rect: ColorRect, color: String) -> void:
	rect.color = color

func _on_NewGame_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		$AudioStreamPlayer.play()
		var _x = get_tree().change_scene("res://scenes/Game.tscn")

func _on_Quit_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		get_tree().quit()

func _on_NewGame_mouse_entered():
	change_rect_color($NewGame, rubyRed)

func _on_NewGame_mouse_exited():
	change_rect_color($NewGame, white)

func _on_Quit_mouse_entered():
	change_rect_color($Quit, rubyRed)

func _on_Quit_mouse_exited():
	change_rect_color($Quit, white)
