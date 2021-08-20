extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var speed: float = 50
onready var animated_player = $AnimationPlayer


func _physics_process(delta) -> void:
	position.y += speed * delta

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Item_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		Signals.emit_signal("player_coin_amount_changed", 1)
		animated_player.play("picked_up")
	#pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "picked_up":
		queue_free()
	#pass # Replace with function body.
