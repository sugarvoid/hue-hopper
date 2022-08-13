class_name GhostSprite
extends Node2D

onready var tween: Tween = get_node("Tween")

onready var guy_sprite: AnimatedSprite = get_node("Guy")
onready var ball_sprite: Sprite = get_node("Ball")
onready var whiteout_sprite: Sprite = get_node("WhiteOut")

func copy_player(player) -> void:
	self.ball_sprite.rotation_degrees = player.ball.rotation_degrees
	self.ball_sprite.texture = player.ball_sprite.texture
	self.guy_sprite.frames = player.grey_guy.frames
	self.guy_sprite.flip_h = player.grey_guy.flip_h
	self.guy_sprite.animation = player.grey_guy.animation
	self.global_position = player.global_position


func _ready() -> void:
	tween.interpolate_property(self, "modulate:a", 1.0, 0.0, 0.5, 3, 1)
	tween.start()


