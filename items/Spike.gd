extends "res://items/Item.gd"



func _ready():
	self.fall_speed = 60
	self.item_id = GameLogic.PICKUPS.SPIKE

func item_action():
	Signals.emit_signal("player_touched_spike")




