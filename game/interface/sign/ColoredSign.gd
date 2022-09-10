class_name ColoredSign
extends Node2D

onready var lights: Node2D = get_node("Lights")
onready var blue_light: Sprite = get_node("Lights/Blue")
onready var yellow_light: Sprite = get_node("Lights/Yellow")
onready var purple_light: Sprite = get_node("Lights/Purple")
onready var orange_light: Sprite = get_node("Lights/Orange")


func update_lights(color: String) -> void:
	_turn_off_all_lights()
	match color:
		"Yellow":
			yellow_light.turn_on()
		"Purple":
			purple_light.turn_on()
		"Blue":
			blue_light.turn_on()
		"Orange":
			orange_light.turn_on()

func _turn_off_all_lights() -> void:
	for light in lights.get_children():
		light.turn_off()
