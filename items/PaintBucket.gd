extends "res://items/Item.gd"


func _ready():
	self.fall_speed = 190
	self.item_id = Global.PICKUPS.PAINT

func item_action():
	self.fall_speed = 0
	self.animated_sprite.play("paint_break")
	Signals.emit_signal("player_touched_paint")

func _process(delta):
	self.rotation_degrees += 9


