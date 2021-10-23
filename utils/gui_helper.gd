


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const prillyBlue: String = "329cc3"
const rubyRed: String = "c13354"
const white: String = "ffffff"


# Called when the node enters the scene tree for the first time.
static func change_rect_color(rect: ColorRect, color: String) -> void:
	rect.color = color


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
