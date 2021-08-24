extends Control

const MISS: int = 3
const HIT: int = 1

var p_heart_icon = preload("res://hud/HeartIcon.tscn")
var last_color: String = "Yellow"
var player_coins: int
var player_score: int

onready var heart_container: HBoxContainer = $LifeContainer
onready var label: Label = $Order

var colors: Array = [
	"Red",
	"Purple",
	"Yellow",
	"Green"
]

func _ready() -> void:
	player_coins = 1
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
	for _i in range(hearts):
		heart_container.add_child(p_heart_icon.instance())

func update_player_coins(amount: int):
	player_coins += amount
	$CoinLabel.set_text(str(player_coins))

func check_player(player_color: String):
	var next_color: String = colors[randi() % colors.size()]
	if player_color == self.last_color:
		$SoundRight.play()
		player_score += (HIT * player_coins)
	else:
		$SoundWrong.play()
		player_score -= (MISS * player_coins)
	change_label_text(next_color)
	if player_score < 0:
		player_score = 0
	$ScoreLabel.set_text(str(player_score))
	self.last_color = next_color


func _on_player_life_change(hearts: int):
	set_hearts(hearts)
