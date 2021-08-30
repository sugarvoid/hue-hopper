extends Area2D

var speed: float = 50

onready var animated_player = $AnimationPlayer


func _physics_process(delta) -> void:
	position.y += speed * delta

func _on_Item_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		call_deferred("disable_item_collision") 
		body.take_damage()
		queue_free()

# To prevent body enetered from triggering twice if coin is lower to ground
func disable_item_collision() -> void:
	$CollisionShape2D.set_disabled(true)


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
