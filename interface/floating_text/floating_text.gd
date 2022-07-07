extends Position2D

onready var tween = $Tween

var velecity = Vector2(rand_range(-50, 50), -100)
var gravity = Vector2(0, 1)
var _color: Color
var mass = 250
var is_set: bool
var _text: String = ""


func setup(text: String, color: Color) -> void:
	$Label.set_text(text)
	$Label.add_color_override("font_color", color)
	is_set = true


func _ready():
	setup("99", Color.red)
	if !is_set:
		#TODO: add error
		push_error("Point text was not set")
		assert(false)
	tween.interpolate_property(self, "scale", Vector2(1, 1), Vector2.ZERO, 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()


func _process(delta):
	print(self.scale)
	velecity += gravity * mass * delta
	position += velecity * delta


func _on_Tween_tween_all_completed():
	queue_free()

