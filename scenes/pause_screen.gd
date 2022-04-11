extends Control


func _ready() -> void:
	set_visiblity(false) # Hides pause screen and all childen 

func _process(delta):
	if $CanvasLayer/Background.visible:
		$AnimationPlayer.play("blink")
	else:
		$AnimationPlayer.stop()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		set_visiblity(!get_tree().paused)
		get_tree().paused = !get_tree().paused #toggles 

func set_visiblity(is_visible: bool) -> void:
	for node in $CanvasLayer.get_children():
		node.visible = is_visible
