extends KinematicBody2D

class_name Enemy

#TODO: make enum or dic
const diriction_dic: Dictionary = {"left": -1, "right": 1}
export var diriction = -1

onready var animated_sprite = $AnimatedSprite

const GRAVITY: float = 700.0
const UP = Vector2(0, -1)
var velocity: Vector2 = Vector2.ZERO
var is_facing_right: bool = true
var is_attacking: bool = false
var speed: float
var attack: int
var health: int
var knockback: int = 100
var knockup: int = 50


#export var health: int
# var speed: int
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.

func _ready() -> void:
	speed = 15
	
	if diriction == diriction_dic["right"]:
		flip_sprite() 

func flip_sprite() -> void:
	self.scale.x *= -1 

func _physics_process(delta: float) -> void:
	
	
	if velocity.y > GRAVITY:
		velocity.y = GRAVITY
		
	velocity.y += GRAVITY * delta
	#velocity.x = lerp(velocity.x,0,0.2)
	
	
	if not is_facing_right:
		flip_sprite()
		is_facing_right = true
	
	velocity.x = speed * diriction
	velocity = move_and_slide(velocity)




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func take_damage(amount: int):
	#var old_health = health
	#health -= amount
	self.health -= amount
	emit_signal("health_changed")
	
func is_dead() -> bool:
	if self.health == 0:
		return true
	else:
		return false











func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
	#pass # Replace with function body.


func _on_Area2D_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("got player")
		body.take_damage()
	#pass # Replace with function body.
