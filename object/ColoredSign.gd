extends Node2D


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

