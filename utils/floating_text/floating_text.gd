extends Position2D

onready var tween = $Tween

#var velecity = Vector2(50, -100)
var velecity = Vector2(rand_range(-50, 50), -100)
var gravity = Vector2(0, 1)
var _color: Color
var mass = 200

var _text: String = ""
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func set_text(text: String, color: Color) -> void:
	self._text = text
	$Label.set_text(text)
	$Label.add_color_override("font_color", color)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	if self._text == "":
		pass
		#TODO: add error
		return
	
	tween.interpolate_property(self, "scale", scale, Vector2(1, 1), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property(self, "scale", Vector2(1, 1), Vector2(0.1, 0.1), 0.7, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.3)
	tween.start()
	


#	"""
#	fade from current color after 0.7 sec
#	"""
#
#	tween.interpolate_property(self, "modulate",
#		Color(modulate.r, modulate.g, modulate.b, modulate.a),
#		Color(modulate.r, modulate.g, modulate.b, 0.0),
#		0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.7)
#	# Replace with function body.
#
#	"""
#	increse size
#	after 0.6 sec, start to shinrk
#	"""
#	tween.interpolate_property(self, "scale",
#		Vector2(0, 0),
#		Vector2(1.0, 1.0),
#		0.3, Tween.TRANS_QUART, Tween.EASE_OUT)
#
#	tween.interpolate_property(self, "scale",
#		Vector2(1.0, 1.0),
#		Vector2(0.4, 0.4),
#		1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.6)
#
#	"""
#	after 1 sec, remove text
#	"""
#	#tween.interpolate_callback(self, 1.0, "remove")
#
#
#	tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velecity += gravity * mass * delta
	position += velecity * delta


func _on_Tween_tween_all_completed():
	queue_free()
	#pass # Replace with function body.
