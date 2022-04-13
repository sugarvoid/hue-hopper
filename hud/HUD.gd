extends Control

class_name HUD

var HeartIcon = preload("res://hud/HeartIcon.tscn")

onready var heart_container: HBoxContainer = $LifeContainer
onready var debuff_label: Label = $Debuff

var is_combo_active: bool = false

func _process(delta):
	debuff_label.text = GameLogic.get_current_debuff()
	$ComboBar.value = $ComboBar/ComboTimer.time_left

func _ready() -> void:
	clear_hearts()
	Signals.connect("player_stat_changed", self, "update_hud")
	Signals.connect("player_has_landed_on_ground", self, "start_combo_decrease")
	Signals.connect("color_changed", self, "_update_color_label")

func clear_hearts():
	for heart in heart_container.get_children():
		heart.queue_free()

func reset_combo(time: int) -> void:
	$ComboBar/ComboTimer.start(time)

func start_combo_decrease(x):
	is_combo_active = true
	$ComboBar/ComboTimer.start(3)
	
	

func _update_color_label(new_color: String) -> void:
	var _color: Color
	#FIXME: Find better way to st color so i can add mix match color debuff. 
	#Maybe a dictionaty and when debuff is one get randon color. else get right color
	
	match new_color:
		"Yellow":
			_color = Color.gold
		"Green":
			_color = Color.darkgreen
		"Purple":
			_color = Color.purple
		"Red":
			_color = Color.red
	$Panel/Order.set("custom_colors/font_color", _color)
	$Panel/Order.set_text(new_color)

func update_player_coins(amount: int): # Combinded with update_hud. Might seperate later
	pass
	###PlayerData.coins += amount
	###$CoinLabel.set_text(str(PlayerData.coins))

func change_score_color() -> void:
	$ScoreLabel.add_color_override("font_color", Color.azure)

func update_player_score(amount: int):
	$ScoreLabel.set_text(str(amount))

func update_hud() -> void:
	$ScoreLabel.set_text(str(PlayerData.get_player_score()))
	##$CoinLabel.set_text(str(PlayerData.coins))
	clear_hearts()
	for _i in range(PlayerData.hearts):
		heart_container.add_child(HeartIcon.instance())


func _on_ComboTimer_timeout():
	is_combo_active = false
