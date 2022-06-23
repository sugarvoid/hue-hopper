extends Position2D

onready var tween = $Tween

#var velecity = Vector2(50, -100)
var velecity = Vector2(rand_range(-50, 50), -100)
var gravity = Vector2(0, 1)
var _color: Color
var mass = 200
var _text: String = ""


func set_text(text: String, color: Color) -> void:
	self._text = text
	$Label.set_text(text)
	$Label.add_color_override("font_color", color)


func _ready():
	
	if self._text == "":
		pass
		#TODO: add error
		return
	
	tween.interpolate_property(self, "scale", scale, Vector2(1, 1), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property(self, "scale", Vector2(1, 1), Vector2(0.1, 0.1), 0.7, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.3)
	tween.start()
	


func _process(delta):
	velecity += gravity * mass * delta
	position += velecity * delta


func _on_Tween_tween_all_completed():
	queue_free()

