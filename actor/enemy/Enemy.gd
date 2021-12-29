extends KinematicBody2D

class_name Enemy

onready var animated_sprite = $AnimatedSprite

const GRAVITY: float = 700.0
const UP = Vector2(0, -1)
var velocity: Vector2 = Vector2.ZERO
var diriction = -1
var is_facing_right: bool = true
var speed: float = 30
var color: String
var colors: Array = [
	"red",
	"purple",
	"yellow",
	"green"
]

func get_random_color() -> String:
	return colors[randi() % colors.size()]

func _ready() -> void:
	randomize()
	self.animated_sprite.play(self.color)
	if diriction == 1:
		flip_sprite() 

func flip_sprite() -> void:
	self.scale.x *= -1 

func _physics_process(delta: float) -> void:
	
	if velocity.y > GRAVITY:
		velocity.y = GRAVITY
		
	velocity.y += GRAVITY * delta
	
	if not is_facing_right:
		flip_sprite()
		is_facing_right = true
	
	velocity.x = speed * diriction
	velocity = move_and_slide(velocity)


func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

func _slide_down() -> void:
	$CollisionShape2D.queue_free()
	self.position = Vector2(self.position.x, self.position.y + 1)

func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		if self.color == body.get_bottom_color().to_lower(): # Checks if player bottom matches enemy color
			PlayerData.multiplier += 1
			#TODO: needs fixing. position 
			#$AnimationPlayer.play("Die")
			_slide_down()
			#queue_free()
		else:
			pass
			## Removed player taking damage ##
			### body.take_damage()


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Die":
			queue_free()
