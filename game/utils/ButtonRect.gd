extends ColorRect


export var button_text: String = "replace"

var button_color: Color = Color.white
var button_color_hover: String = "c13354"

onready var button_label: Label = $Text


func _ready() -> void:
	button_label.set_text(button_text)
	self.color = button_color


func _on_ButtonRect_mouse_entered() -> void:
	self.color = button_color_hover


func _on_ButtonRect_mouse_exited() -> void:
	self.color = button_color 
