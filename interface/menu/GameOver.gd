extends Node2D

var GuiHelper = preload("res://utils/gui_helper.gd")
var current_high_score: int

onready var player_score = get_node("PlayerScore")

func _ready():
	current_high_score = load_high_score()
	if PlayerData.get_player_score() > current_high_score:
		current_high_score = PlayerData.get_player_score()
		save_high_score(current_high_score)
		
	$PlayerScore.set_text("Score: " + str(PlayerData.get_player_score()))
	$HighScore.set_text("Best: " + str(current_high_score))
	if Global.is_fx_enabled:
		$AudioStreamPlayer.play()


func _unhandled_key_input(event):
	if event.is_action_released("restart"):
		var _x = get_tree().change_scene("res://scenes/StartScreen.tscn")


func load_high_score():
	var highscore: int
	var f = File.new()
	if f.file_exists(Global.HIGH_SCORE_FILE):
		f.open(Global.HIGH_SCORE_FILE, File.READ)
		highscore = f.get_var()
		f.close()
		return highscore


func save_high_score(score: int):
	var f = File.new()
	f.open(Global.HIGH_SCORE_FILE, File.WRITE)
	f.store_var(score)


func _on_Restart_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		get_tree().change_scene("res://scenes/StartScreen.tscn")


func _on_Restart_mouse_entered():
	GuiHelper.change_rect_color($Restart, GuiHelper.rubyRed)


func _on_Restart_mouse_exited():
	GuiHelper.change_rect_color($Restart, GuiHelper.white)