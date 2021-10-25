extends "res://items/Item.gd"

func _ready():
	self.item_id = GameData.PICKUPS.SPIKE

func item_action():
	Signals.emit_signal("player_touched_spike")
