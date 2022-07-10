extends "res://items/FallingItem.gd"
class_name Flask



var orb_id: int


func select_effect():
	# TODO: add way to change effect
	pass

func _set_sprite(o_id: int):
	match o_id:
		Global.DEBUFFS.BOUNCE_DOWN:
			animated_sprite.play("orb2")
		Global.DEBUFFS.ROTATION:
			animated_sprite.play("orb1")
		Global.DEBUFFS.ROTATION_UP:
			animated_sprite.play("orb3")
		_:
			Global.raise_error("A vaild debuff was not set!")
		

func _ready():
	self.orb_id = Global.DEBUFFS.ROTATION_UP
	self._set_sprite(self.orb_id)
	self.fall_speed = 50
	self.item_id = Global.PICKUPS.GEM

func item_action():
	Signals.emit_signal("on_orb_pickup", orb_id)

