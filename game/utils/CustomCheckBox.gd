extends HBoxContainer

export var label_text: String = "replace"

func _ready():
	$Label.set_text(label_text)

