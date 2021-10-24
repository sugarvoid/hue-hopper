extends Node2D

var GuiHelper = preload("res://utils/gui_helper.gd")
var current_high_score: int

func _ready():
	current_high_score = load_high_score()
	if PlayerData.get_player_score() > current_high_score:
		current_high_score = PlayerData.get_player_score()
		save_high_score(current_high_score)
		
	###save_high_score(45)
	$PlayerScore.set_text("Score: " + str(PlayerData.get_player_score()))
	$HighScore.set_text("Best: " + str(current_high_score))
	if GameSettings.is_fx_enabled:
		$AudioStreamPlayer.play()


func load_high_score():
	var highscore: int
	var f = File.new()
	if f.file_exists(GameSettings.high_score_file):
		f.open(GameSettings.high_score_file, File.READ)
		highscore = f.get_var()
		f.close()
		return highscore
		
func save_high_score(score: int):
	var f = File.new()
	f.open(GameSettings.high_score_file, File.WRITE)
	f.store_var(score)

func _on_Restart_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		get_tree().change_scene("res://scenes/StartScreen.tscn")


func _on_Restart_mouse_entered():
	GuiHelper.change_rect_color($Restart, GuiHelper.rubyRed)
	pass # Replace with function body.


func _on_Restart_mouse_exited():
	GuiHelper.change_rect_color($Restart, GuiHelper.white)
	pass # Replace with function body.
