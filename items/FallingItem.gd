extends Area2D
class_name FallingItem

var fall_speed: float = 0
var item_id: int = -7
enum ItemTypes {
	FLASK,
	PAINT_BUCKET
}
var type: int

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")



func _process(delta) -> void:
	position.y += fall_speed * delta

func _ready() -> void:
	pass

func _set_sprite(item_type: int) -> void:
	match item_type:
		ItemTypes.FLASK:
			animated_sprite.play("flask")
		ItemTypes.PAINT_BUCKET:
			animated_sprite.play("paint_whole")
	

func item_action() -> void:
	assert(false, "Override the '_item_action()' function.")

func _on_Item_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		self.item_action()
		call_deferred("disable_item_collision") 
		queue_free()

# To prevent body enetered from triggering twice if coin is lower to ground
func disable_item_collision() -> void:
	$CollisionShape2D.set_disabled(true)


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


