extends Node2D


func _ready():
	$AnimationPlayer.play("pump")

func fall_apart():
	$AnimationPlayer.stop(true)
	$Whole.visible = false
	$LeftHalf.visible = true
	$RightHalf.visible = true
	$AnimationPlayer.play("break_heart")


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
