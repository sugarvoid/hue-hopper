extends Control

onready var background: TextureRect = get_node("CanvasLayer/Background")
onready var canvas_layer: CanvasLayer = get_node("CanvasLayer")
onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

func _ready() -> void:
	set_visiblity(false) # Hides pause screen and all childen 

func _process(_delta) -> void:
	if background.visible:
		animation_player.play("blink")
	else:
		animation_player.stop()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		set_visiblity(!get_tree().paused)
		get_tree().paused = !get_tree().paused #toggles 

func set_visiblity(is_visible: bool) -> void:
	for node in canvas_layer.get_children():
		node.visible = is_visible
