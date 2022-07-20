extends Area2D
class_name FallingItem

var item_id: int
var fall_speed: float = 0
var rotation_speed: int
var debuff_id: int
var type: int
var does_rotate: bool 

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")

func setup(id: int) -> void:
	self.item_id = id
	_set_fall_speed()
	if id == Global.ITEMS.ORANGE_FLASK:
		debuff_id = _get_random_debuff_id()

func _process(delta) -> void:
	position.y += fall_speed * delta
	if self.does_rotate:
		self.rotation_degrees += rotation_speed

func _ready() -> void:
	_set_sprite(self.item_id)

func _set_fall_speed() -> void:
	match(self.item_id):
		Global.ITEMS.PAINT_BUCKET:
			self.fall_speed = 190
			self.rotation_speed = 9
		Global.ITEMS.ORANGE_FLASK:
			self.fall_speed = 50
			self.rotation_speed = 3

func _set_sprite(item_type: int) -> void:
	match item_type:
		Global.ITEMS.ORANGE_FLASK:
			animated_sprite.play("flask_orange")
		Global.ITEMS.PAINT_BUCKET:
			animated_sprite.play("paint_whole")

func do_item_effect() -> void:
	match self.type:
		Global.ITEMS.ORANGE_FLASK:
			Signals.emit_signal("apply_effect", self.debuff_id)
		Global.ITEMS.PAINT_BUCKET:
			SoundManager.play(Global.AUDIO_PATHS.glass)
			Signals.emit_signal("apply_effect", Global.EFFECTS.WHITE_OUT)
			self.fall_speed = 0
			self.animated_sprite.play("paint_break")

func _on_Item_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		self.do_item_effect()
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

