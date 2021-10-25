extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var button_text: String = "replace"
var button_color: Color = Color.white
var button_color_hover: String = "c13354"
onready var button_label: Label = $Text


# Called when the node enters the scene tree for the first time.
func _ready():
	
	button_label.set_text(button_text)
	self.color = button_color
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func on_click():
	pass

func _on_ButtonRect_focus_entered():
	
	pass # Replace with function body.


func _on_ButtonRect_mouse_entered():
	self.color = button_color_hover
	pass # Replace with function body.


func _on_ButtonRect_mouse_exited():
	self.color = button_color 
	#pass # Replace with function body.

