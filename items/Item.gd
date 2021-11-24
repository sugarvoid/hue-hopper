extends Area2D

var fall_speed: float = 0
var item_id: int = -7



func _physics_process(delta) -> void:
	position.y += fall_speed * delta

func _ready() -> void:
	pass

func item_action() -> void:
	#TODO: THIS IS ERROR COODE
	assert(false, "Override the '_item_action()' function.")

func _on_Item_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		self.item_action()
		call_deferred("disable_item_collision") 
		queue_free()
		

# To prevent body enetered from triggering twice if coin is lower to ground
func disable_item_collision() -> void:
	$CollisionShape2D.set_disabled(true)


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


