extends Node


onready var start_timer: Timer = $StartAnimation
onready var pause_timer: Timer = $Pause
onready var animation_player: AnimationPlayer = $AnimationPlayer
const MAIN_MENU_SCENE: String = "res://scenes/StartScreen.tscn"


func _ready() -> void:
	
	start_timer.start(0.5)


func _on_StartAnimation_timeout() -> void:
	$Sound.play()
	animation_player.play("rise_logo")
	


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "rise_logo":
		pause_timer.start(1.9)


func _on_Pause_timeout() -> void:
	var _x = get_tree().change_scene(MAIN_MENU_SCENE)
