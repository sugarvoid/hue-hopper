extends Area2D


export var speed: float = 50
onready var animated_player = $AnimationPlayer


func _physics_process(delta) -> void:
	position.y += speed * delta

func _on_Item_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.add_coin(1)
		Signals.emit_signal("player_coin_amount_changed", 1)
		animated_player.play("picked_up")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "picked_up":
		queue_free()



func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
	#pass # Replace with function body.
