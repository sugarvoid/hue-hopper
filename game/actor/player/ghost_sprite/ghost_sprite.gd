class_name GhostSprite
extends Node2D

onready var tween: Tween = get_node("Tween")

onready var guy_sprite: Sprite = get_node("Guy")
onready var ball_sprite: Sprite = get_node("Ball")
onready var whiteout_sprite: Sprite = get_node("WhiteOut")

func copy_player(player: Player) -> void:
	self.rotation_degrees = player.ball.rotation_degrees
	self.ball_sprite.texture = player.ball_sprite.texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tween.interpolate_property(self, "modulate:a", 1.0, 0.0, 0.5, 3, 1)
	tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
