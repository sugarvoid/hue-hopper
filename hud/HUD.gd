extends Control

const MISS: int = 10
const HIT: int = 5

var HeartIcon = preload("res://hud/HeartIcon.tscn")

onready var heart_container: HBoxContainer = $LifeContainer
onready var label: Label = $Order

var colors: Array = [
	"Red",
	"Purple",
	"Yellow",
	"Green"
]

func _ready() -> void:
	###change_label_text(Global.last_color)
	clear_hearts()
	Signals.connect("player_stat_changed", self, "update_hud")
	Signals.connect("color_changed", self, "_update_color_label")
	#Signals.connect("on_player_life_change", self, "_on_player_life_change")
	#Signals.connect("player_has_landed", self, "check_player")
	Signals.connect("player_coin_amount_changed", self, "update_player_coins")

func change_label_text(s: String):
	label.set_text(s)

func clear_hearts():
	for heart in heart_container.get_children():
		heart.queue_free()

func set_hearts(hearts: int):
	clear_hearts()
	for _i in range(hearts):
		heart_container.add_child(HeartIcon.instance())

func _update_color_label(new_color: String) -> void:
	$Order.set_text(new_color)

func update_player_coins(amount: int):
	pass
	###PlayerData.coins += amount
	###$CoinLabel.set_text(str(PlayerData.coins))

func update_hud() -> void:
	$ScoreLabel.set_text(str(PlayerData.get_player_score()))
	$CoinLabel.set_text(str(PlayerData.coins))
	clear_hearts()
	for _i in range(PlayerData.hearts):
		heart_container.add_child(HeartIcon.instance())

