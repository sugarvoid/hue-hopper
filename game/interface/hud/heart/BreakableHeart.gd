extends Node2D


func _ready():
	_reset_heart()

func _reset_heart():
	self.visible = true
	$AnimationPlayer.play("pump")

func fall_apart():
	$AnimationPlayer.stop(true)
	$Whole.visible = false
	$LeftHalf.visible = true
	$RightHalf.visible = true
	$AnimationPlayer.play("break_heart")

func _on_AnimationPlayer_animation_finished(anim_name):
	self.visible = false
