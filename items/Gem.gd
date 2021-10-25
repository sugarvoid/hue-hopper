extends "res://items/Item.gd"

func _ready():
	self.fall_speed = 50
	self.item_id = GameData.PICKUPS.GEM

func item_action():
	PlayerData.coins += 1
	print(PlayerData.coins)
