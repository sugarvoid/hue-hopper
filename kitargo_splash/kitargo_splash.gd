extends Node

onready var logo_sound: AudioStreamPlayer = get_node("AudioStreamPlayer")
onready var start_timer: Timer = get_node("TimerStartAnim")
onready var delay_timer: Timer = get_node("TimerDelay")
onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

const MAIN_MENU_SCENE: String = "res://game/interface/menu/StartScreen.tscn"

func _ready() -> void:
	start_timer.start(0.3)

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "rise_logo":
		pass

func _on_AudioStreamPlayer_finished():
	Global.go_to_start_screen()

func _on_TimerStartAnim_timeout():
	logo_sound.play()
	animation_player.play("rise_logo")

func _on_TimerDelay_timeout():
	var _x = get_tree().change_scene(MAIN_MENU_SCENE)
