extends Node2D


var current_high_score: int


func _ready():
	current_high_score = Global.get_high_score()
	if Global.player_score > current_high_score:
		current_high_score = Global.player_score
		save_high_score(current_high_score)
		
	$PlayerScore.set_text("Score: " + str(Global.player_score))
	$HighScore.set_text("Best: " + str(current_high_score))
	if Global.is_fx_enabled:
		$AudioStreamPlayer.play()

func _unhandled_key_input(event):
	if event.is_action_released("restart"):
		Global.go_to_start_screen()



func save_high_score(score: int):
	var f = File.new()
	f.open(Global.HIGH_SCORE_FILE, File.WRITE)
	f.store_var(score)

func _on_Restart_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		get_tree().change_scene("res://scenes/StartScreen.tscn")

func _on_Restart_mouse_entered():
	Global.change_rect_color($Restart, Global.rubyRed)

func _on_Restart_mouse_exited():
	Global.change_rect_color($Restart, Global.white)
