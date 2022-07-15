extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("pump")

func fall_apart():
	$AnimationPlayer.stop(true)
	$Whole.visible = false
	$LeftHalf.visible = true
	$RightHalf.visible = true
	$AnimationPlayer.play("break_heart")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
