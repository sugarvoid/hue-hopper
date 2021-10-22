extends Node

#var player_coins: int
#var player_score: int
#var player_hearts: int

#signal on_player_life_change(hearts)
#signal player_has_landed(position)
#signal player_score_changed(amount)
#signal player_coin_amount_changed(amount)

const MISS: int = 10
const HIT: int = 5


var last_color: String = "Yellow"
var current_color: String


var colors: Array = [
	"Red",
	"Purple",
	"Yellow",
	"Green"
]

func get_random_color() -> String:
	return colors[randi() % colors.size()]
