extends Node

const MISS: int = 10
const HIT: int = 5

const prillyBlue: String = "329cc3"
const rubyRed: String = "c13354"
const white: String = "ffffff"

var last_color: String = "Yellow"
var current_color: String


func change_rect_color(rect: ColorRect, color: String) -> void:
	rect.color = color


var colors: Array = [
	"Red",
	"Purple",
	"Yellow",
	"Green"
]

func get_random_color() -> String:
	return colors[randi() % colors.size()]
