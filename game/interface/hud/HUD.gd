class_name HUD
extends Control


var HeartIcon = preload("res://game/interface/hud/HeartIcon.tscn")

onready var heart_container: HBoxContainer = $LifeContainer
onready var debuff_label: Label = $Debuff

var is_combo_active: bool = false

func _process(_delta):
	
	$ComboBar.value = $ComboBar/ComboTimer.time_left


func clear_hearts() -> void:
	for heart in heart_container.get_children():
		heart.queue_free()

func reset_combo(time: int) -> void:
	$ComboBar/ComboTimer.start(time)

func start_combo_decrease(x) -> void:
	is_combo_active = true
	$ComboBar/ComboTimer.start(3)

func change_score_color() -> void:
	$ScoreLabel.add_color_override("font_color", Color.azure)

func update_score(amount: int) -> void:
	$ScoreLabel.set_text(str(amount))

func update_hearts(amount: int) -> void:
	clear_hearts()
	for _i in range(amount):
		heart_container.add_child(HeartIcon.instance())

func update_debuff(debuff: String) -> void:
	debuff_label.text = debuff

func _on_ComboTimer_timeout() -> void:
	is_combo_active = false
