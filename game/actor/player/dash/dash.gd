class_name Dash
extends Node2D

const ghost_sprites: PackedScene = preload("res://game/actor/player/ghost_sprite/GhostSprite.tscn")

onready var duration_timer = get_node("DurationTimer")
onready var ghost_timer = get_node("GhostTimer")

var player_parent

func start_dash(player, duration: float) -> void:
	player_parent = player
	duration_timer.wait_time = duration
	duration_timer.start()
	ghost_timer.start()
	instance_ghost(player)
	

func instance_ghost(player) -> void:
	var ghost: GhostSprite = ghost_sprites.instance()
	
	get_parent().get_parent().add_child(ghost)
	ghost.copy_player(player)

func is_dashing():
	return !duration_timer.is_stopped()


func _on_GhostTimer_timeout() -> void:
	instance_ghost(self.player_parent)


func _on_DurationTimer_timeout() -> void:
	ghost_timer.stop()
