extends Area2D

var fall_speed: float = 60
var item_id: int = -7



func _physics_process(delta) -> void:
	position.y += fall_speed * delta

func item_action() -> void:
	assert(false, "Override the '_item_action()' function.")

func _on_Item_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		self.item_action()
		#Signals.emit_signal("player_touched_spike")
		#Signals.emit_signal("player_picked_up_item", self.item_id)
		call_deferred("disable_item_collision") 
		queue_free()

		body.take_damage()
		

# To prevent body enetered from triggering twice if coin is lower to ground
func disable_item_collision() -> void:
	$CollisionShape2D.set_disabled(true)


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


