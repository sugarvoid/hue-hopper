extends "res://items/Item.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var debuff_id: int = -99

func select_effect():
	# TODO: add way to change effect
	pass

func _set_sprite(debuff_id: int):
	match debuff_id:
		GameLogic.DEBUFFS.BOUNCE_DOWN:
			$AnimatedSprite.play("orb2")
		GameLogic.DEBUFFS.ROTATION:
			pass
		_:
			assert(false, "A vaild debuff was not selected")
		

func _ready():
	self._set_sprite(self.debuff_id)
	self.fall_speed = 50
	self.item_id = GameLogic.PICKUPS.GEM

func item_action():
	Signals.emit_signal("apply_debuff", debuff_id)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
