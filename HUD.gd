extends Control


const MISS: int = 25
const HIT: int = 50



var p_heart_icon = preload("res://HeartIcon.tscn")
var last_color: String = "Yellow"
var player_coins: int
var player_score: int

onready var heart_container: HBoxContainer = $LifeContainer
onready var label: Label = $HBoxContainer2/Order

var colors: Array = [
	"Red",
	"Blue",
	"Yellow",
	"Green"
]

func _ready() -> void:
	player_coins = 0
	change_label_text("Yellow")
	clear_hearts()
	Signals.connect("on_player_life_change", self, "_on_player_life_change")
	Signals.connect("player_has_landed", self, "check_player")
	Signals.connect("player_coin_amount_changed", self, "update_player_coins")

func change_label_text(s: String):
	label.set_text(s)

func clear_hearts():
	for heart in heart_container.get_children():
		heart.queue_free()

func set_hearts(hearts: int):
	clear_hearts()
	for i in range(hearts):
		heart_container.add_child(p_heart_icon.instance())

func update_player_coins(amount: int):
	player_coins += amount
	$CoinLabel.set_text(str(player_coins))

func check_player(player_color: String):
	var next_color: String = colors[randi() % colors.size()]
	if player_color == self.last_color:
		player_score += HIT
	else:
		player_score -= MISS
	change_label_text(next_color)
	$ScoreLabel.set_text(str(player_score))
	self.last_color = next_color


func _on_player_life_change(hearts: int):
	set_hearts(hearts)
