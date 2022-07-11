extends Area2D
class_name FallingItem

var fall_speed: float = 0
var item_id: int

var debuff_id: int

var type: int

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")

func setup(id: int) -> void:
	self.item_id = id
	_set_fall_speed()
	
	if id == Global.ITEMS.FLASK:
		debuff_id = _get_random_debuff_id()
	

func _process(delta) -> void:
	position.y += fall_speed * delta

func _ready() -> void:
	_set_sprite(self.item_id)

func _set_fall_speed() -> void:
	match(self.item_id):
		Global.ITEMS.PAINT_BUCKET:
			self.fall_speed = 190
		Global.ITEMS.FLASK:
			self.fall_speed = 50

func _set_sprite(item_type: int) -> void:
	match item_type:
		Global.ITEMS.FLASK:
			animated_sprite.play("flask")
		Global.ITEMS.PAINT_BUCKET:
			animated_sprite.play("paint_whole")

func item_action() -> void:
	match item_id:
		Global.ITEMS.FLASK:
			Signals.emit_signal("apply_debuff", self.debuff_id)
		Global.ITEMS.PAINT_BUCKET:
			SoundManager.play(Global.AUDIO_PATHS.glass)
			Signals.emit_signal("apply_debuff", Global.DEBUFFS.WHITE_OUT)
			self.fall_speed = 0
			self.animated_sprite.play("paint_break")
		

func _on_Item_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		self.item_action()
		call_deferred("disable_item_collision") 
		queue_free()

# To prevent body enetered from triggering twice if coin is lower to ground
func disable_item_collision() -> void:
	$CollisionShape2D.set_disabled(true)

func _get_random_debuff_id() -> int:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(0, 3)

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


