extends Node

enum {
	ARG_INT,
	ARG_STRING,
	ARG_BOOL,
	ARG_FLOAT
}

const valid_commands = [
	["set_hearts",
		[ARG_INT] ]
]


func _ready() -> void:
	pass # Replace with function body.

func set_hearts(hearts) -> String:
	hearts = int(hearts)
	if hearts >= 1 and hearts <= 10:
		PlayerData.hearts = hearts
		return str("Sucessfully set hearts to ", hearts, ".")
	return "No higher than 10, please."

