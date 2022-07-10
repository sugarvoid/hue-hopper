extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func update_lights(color: String):
	for light in $Colors.get_children():
		light.turn_off()
	match color:
		"Yellow":
			$Colors/Yellow.turn_on()
		"Purple":
			$Colors/Purple.turn_on()
		"Red":
			$Colors/Red.turn_on()
		"Green":
			$Colors/Green.turn_on()


func _on_AnimatedSprite_animation_finished():
	pass
