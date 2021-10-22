extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	set_visiblity(false)
	#pass # Replace with function body.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		set_visiblity(!get_tree().paused)
		#$Background.visible = !$Background.visible
		#$Label.visible = !$Label.visible
		get_tree().paused = !get_tree().paused #toggles 

func set_visiblity(is_visible: bool) -> void:
	for node in self.get_children():
		node.visible = is_visible
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
