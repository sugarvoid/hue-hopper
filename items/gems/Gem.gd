extends "res://items/Item.gd"
#TODO: set up all gems, but in one file


var debuff_id: int = GameLogic.DEBUFFS.BOUNCE

func _ready():
	self.fall_speed = 50
	self.item_id = GameLogic.PICKUPS.GEM

func item_action():
	Signals.emit_signal("apply_debuff", debuff_id)

