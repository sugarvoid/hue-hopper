extends Control


func _ready() -> void:
	set_visiblity(false) # Hides pause screen and all childen 

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		set_visiblity(!get_tree().paused)
		get_tree().paused = !get_tree().paused #toggles 

func set_visiblity(is_visible: bool) -> void:
	for node in self.get_children():
		node.visible = is_visible
