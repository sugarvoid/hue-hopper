extends Node2D

onready var audio_player: AudioStreamPlayer = get_node("AudioStreamPlayer")

#TODO: make version label info come from autoload
func _ready():
	PlayerData.init_player_data()
	$LblVersion.text = Global.GAME_VERSION

func _unhandled_key_input(event):
	if event.is_action_released("slam"):
		#play sound
		$AnimationPlayer.play("start_game")

func _is_left_mouse_click(input: InputEventMouseButton) -> bool:
	return (input is InputEventMouseButton 
	and input.button_index == BUTTON_LEFT 
	and input.pressed)


func _on_BtnSettings_gui_input(event):
	if _is_left_mouse_click(event):
		var _x = get_tree().change_scene("res://scenes/ScnSettings.tscn")


func _on_BtnPlay_gui_input(event):
	if _is_left_mouse_click(event):
		if Global.is_fx_enabled:
			audio_player.play()
		var _x = get_tree().change_scene("res://scenes/Game.tscn")


func _on_BtnQuit_gui_input(event):
	if _is_left_mouse_click(event):
		get_tree().quit()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == 'start_game':
		var _x = get_tree().change_scene("res://scenes/Game.tscn")
