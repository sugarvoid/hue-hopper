extends TileMap


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.connect("player_has_landed", self, "_on_Area2D_area_entered")
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_position"):
		Signals.emit_signal("player_has_landed", area.name)
	#pass # Replace with function body.
