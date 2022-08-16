extends Node2D


func update_lights(color: String):
	for light in $Colors.get_children():
		light.turn_off()
	match color:
		"Yellow":
			$Colors/Yellow.turn_on()
		"Purple":
			$Colors/Purple.turn_on()
		"Blue":
			$Colors/Blue.turn_on()
		"Orange":
			$Colors/Orange.turn_on()

