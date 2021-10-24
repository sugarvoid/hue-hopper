extends Camera2D

onready var shake_timer = $Timer
onready var tween = $Tween

var shake_amount = 0
var default_offset = self.offset
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	#self.offset.x = get_viewport_rect().size.x / 2
	#self.offset.y = get_viewport_rect().size.y / 2 
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset = Vector2(rand_range(-shake_amount, shake_amount), rand_range(shake_amount, -shake_amount)) * delta + default_offset
	pass
	
func shake(new_shake, shake_time=0.3, shake_limit=100):
	shake_amount += new_shake
	if shake_amount > shake_limit:
		shake_amount = shake_limit
	
	shake_timer.wait_time = shake_time
	tween.stop_all()
	
	set_process(true)
	shake_timer.start()
	


func _on_Timer_timeout():
	shake_amount = 0
	set_process(false)
	tween.interpolate_property(self, "offset", offset, default_offset, 0.1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()
	pass # Replace with function body.
