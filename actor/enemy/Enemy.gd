extends KinematicBody2D

class_name Enemy

#const diriction_dic: Dictionary = {"left": -1, "right": 1}

onready var animated_sprite = $AnimatedSprite

const GRAVITY: float = 700.0
const UP = Vector2(0, -1)
var velocity: Vector2 = Vector2.ZERO
var diriction = -1
var is_facing_right: bool = true
var speed: float = 15


func _ready() -> void:
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
	#pass # Replace with function body.

func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		body.take_damage()
