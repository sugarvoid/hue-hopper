extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	pass # Replace with function body.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		$Background.visible = !$Background.visible
		$Label.visible = !$Label.visible
		get_tree().paused = !get_tree().paused #toggles 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
