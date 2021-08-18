extends KinematicBody2D

class_name Actor 

signal health_changed()


var GRAVITY: float = 500.0
const UP = Vector2(0, -1)
var velocity: Vector2 = Vector2.ZERO
var is_facing_right: bool = true
var is_attacking: bool = false
var speed: float
var attack: int
var health: int
var knockback: int = 100
var knockup: int = 50

onready var sprite: Sprite = $Sprite

func _physics_process(delta: float) -> void:
	if velocity.y > GRAVITY:
		velocity.y = GRAVITY
		
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	#velocity.x = lerp(velocity.x,0,0.2)
	

func take_damage_old(amount: int):
	self.health -= amount
	emit_signal("health_changed")

func flip_sprite() -> void:
	self.scale.x *= -1 

func get_knocked_back():
	velocity.x -= lerp(velocity.x, knockback, 0.5)
	velocity.y = lerp(0, -knockback, 0.6)
	velocity = move_and_slide(velocity, UP)

func handle_facing_direction(x_input: int):
	if x_input == 1:
		if not is_facing_right:
			flip_sprite()
			is_facing_right = true
	elif x_input == -1:
		if is_facing_right:
			flip_sprite()
			is_facing_right = false
			
func handle_facing_direction_new(x_input: int):
	if x_input > 0:
		if not is_facing_right:
			flip_sprite()
			is_facing_right = true
	elif x_input < 0:
		if is_facing_right:
			flip_sprite()
			is_facing_right = false

#func _follow_player(Player, Follower):
#
#	###	Get Vector2 direction to the player global pos
#	var direction = (Player.get_global_pos() - get_global_pos()).normalized()
#	var DIR = Vector2()
#	###	Get horizontal direction based on the direction to player
#	if direction.x > 0:
#		DIR = Vector2(1, 0)
#	elif direction.x < 0:
#		DIR = Vector2(-1, 0)
#	else:
#		DIR = Vector2(0, 0)
#
#	###	Follow the player in the direction
#	var motion = DIR * 35
#	if Follower.can_move:
#		move_and_slide(motion, FLOOR_NORMAL, SLOPE_FRICTION)
#
