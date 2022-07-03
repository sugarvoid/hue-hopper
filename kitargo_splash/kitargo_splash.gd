extends Node

onready var logo_sound: AudioStreamPlayer = get_node("AudioStreamPlayer")
onready var start_timer: Timer = get_node("Timer_Start_Ani")
onready var pause_timer: Timer = get_node("Timer_Pause")
onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

const MAIN_MENU_SCENE: String = "res://interface/menu/StartScreen.tscn"


func _ready() -> void:
	start_timer.start(0.5)

func _on_StartAnimation_timeout() -> void:
	logo_sound.play()
	animation_player.play("rise_logo")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "rise_logo":
		pass#pause_timer.start(1.9)

func _on_Pause_timeout() -> void:
	var _x = get_tree().change_scene(MAIN_MENU_SCENE)


func _on_AudioStreamPlayer_finished():
	print('done')
	Global.go_to_start_screen()
