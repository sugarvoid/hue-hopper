extends "res://items/Item.gd"

var debuff_id: int = -9

func _ready():
	self.fall_speed = 50
	self.item_id = GameData.PICKUPS.GEM

func item_action():
	Signals.emit_signal("apply_debuff", debuff_id)

